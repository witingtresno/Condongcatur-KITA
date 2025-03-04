import 'package:desa_gempol/model/potensi_desa/get_detail_hamlet.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/provider/potensi_desa/potensi_desa.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DetailDesaScreen extends StatefulWidget {
  const DetailDesaScreen({super.key});

  @override
  State<DetailDesaScreen> createState() => _DetailDesaScreenState();
}

class _DetailDesaScreenState extends State<DetailDesaScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (arguments != null) {
        final idHamlet = arguments['idHamlet'] as String;
        Provider.of<PotensiDesa>(context, listen: false)
            .getDetailHamlet(idHamlet: idHamlet);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'Detail Desa',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: Consumer<PotensiDesa>(builder: (context, detail, _) {
        return dataStateHandler<GetDetailHamlet>(
          status: detail.stateDetailPotensi!,
          onSucces: (value) {
            final detail = value!.data!;
            final galleries = detail.details
                ?.expand((detail) => detail.galleries ?? [])
                .toList();

            final latitude = detail.details?.first.latitude ?? 0.0;
            final longitude = detail.details?.first.longitude ?? 0.0;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Carousel Gambar
                  if (galleries != null && galleries.isNotEmpty)
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1.0,
                      ),
                      items: galleries.map((gallery) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(gallery.image ?? ''),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    )
                  else
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Tidak ada gambar tersedia',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),

                  // Nama Desa
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.grey[800],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail.name ?? 'Nama tidak tersedia',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          detail.title ?? 'Judul tidak tersedia',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Google Map
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 300,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latitude, longitude),
                          zoom: 15,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('hamlet_location'),
                            position: LatLng(latitude, longitude),
                            infoWindow: InfoWindow(
                              title: 'Padukuhan ${detail.name}',
                              // snippet: detail.title ?? 'Koordinat lokasi',
                            ),
                          ),
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          onFailed: (errMessage) {
            return Center(
              child: Text(
                errMessage.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          },
        );
      }),
    );
  }
}
