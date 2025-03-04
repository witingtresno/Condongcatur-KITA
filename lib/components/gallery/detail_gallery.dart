import 'package:desa_gempol/model/gallery/get_detail_gallery.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/provider/gallery/gallery_provider.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailGalleryScreen extends StatefulWidget {
  const DetailGalleryScreen({super.key});

  @override
  State<DetailGalleryScreen> createState() => _DetailGalleryScreenState();
}

class _DetailGalleryScreenState extends State<DetailGalleryScreen> {
  bool _isLoading = true; // Status loading
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      try {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        final galleryId = args['galleryId'];
        final provider = Provider.of<GalleryProvider>(context, listen: false);

        // Ambil ulang data setiap kali halaman dibuka
        await provider.getDetailGallery(idGallery: galleryId.toString());
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
      } finally {
        setState(() {
          _isLoading = false; // Matikan loading
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<GalleryProvider>(context);

    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'Detail Gallery',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: _isLoading
          ? const Center(
              child: SpinKitThreeBounce(
                size: 60,
                color: Colors.grey,
              ), // Indikator loading
            )
          : _errorMessage != null
              ? Center(
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : Consumer<GalleryProvider>(
                  builder: (context, provider, child) {
                    return dataStateHandler<GetDetailGallery>(
                      status: provider.stateDetailGallery!,
                      onSucces: (data) {
                        // Periksa apakah data kosong
                        // if (data?.data?.images == null || data?.data?.images!.isNotEmpty) {
                        //   return const Center(
                        //     child: Text(
                        //       'Data Kosong',
                        //       style: TextStyle(
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   );
                        // }

                        // Tampilkan data jika tidak kosong
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: data?.data?.images!.length,
                                itemBuilder: (context, index) {
                                  final image = data?.data?.images![index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        image?.image ?? '',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.broken_image),
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const Center(
                                            child: SpinKitThreeBounce(
                                              size: 60,
                                              color: Colors.grey,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                      onFailed: (error) => Center(
                        child: Text(
                          error ?? 'Terjadi kesalahan',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
