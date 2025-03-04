import 'package:desa_gempol/provider/auth/auth_provider.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/provider/ulasan/ulasan.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';

class UlasanScreen extends StatefulWidget {
  const UlasanScreen({super.key});

  @override
  _UlasanScreenState createState() => _UlasanScreenState();
}

class _UlasanScreenState extends State<UlasanScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UlasanProvider>(context, listen: false).getUlasan();
    });
  }

  Future<void> _refreshData() async {
    await Provider.of<UlasanProvider>(context, listen: false).getUlasan();
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: PhotoView(
              imageProvider: NetworkImage(imageUrl),
              backgroundDecoration: const BoxDecoration(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          "Ulasan",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Consumer<UlasanProvider>(
          builder: (context, provider, child) {
            final state = provider.stateUlasan;

            if (state?.status == StateStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state?.status == StateStatus.error) {
              return Center(
                child: Text(
                  "Terjadi kesalahan, coba lagi nanti",
                  style: GoogleFonts.poppins(),
                ),
              );
            }

            final ulasanList = state?.data?.data ?? [];

            if (ulasanList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.info, size: 50, color: Colors.blueGrey),
                    const SizedBox(height: 16),
                    Text(
                      'Belum ada ulasan',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: ulasanList.length,
              itemBuilder: (context, index) {
                final ulasan = ulasanList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            (ulasan.user?.name?.isNotEmpty ?? false)
                                ? ulasan.user!.name![0].toUpperCase()
                                : "?",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: Text(
                          ulasan.user?.name ?? "Pengguna Anonim",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: RatingBarIndicator(
                          rating: ulasan.rating?.toDouble() ?? 0.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          ulasan.comment ?? "Tidak ada komentar",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      if (ulasan.image != null && ulasan.image!.isNotEmpty)
                        GestureDetector(
                          onTap: () =>
                              _showFullScreenImage(context, ulasan.image!),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                ulasan.image!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 150,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return FloatingActionButton(
            onPressed: () async {
              if (!authProvider.isLoggedIn) {
                final result = await Navigator.pushNamed(
                  context,
                  CustomRoute.loginScreen,
                );
                if (result != true) return;
              }

              final result = await Navigator.pushNamed(context, CustomRoute.addUlasan);
              if (result == true) {
                await Provider.of<UlasanProvider>(context, listen: false).getUlasan();
              }
            },
            backgroundColor: Config.cardColor,
            child: const Icon(Icons.add, color: Colors.white),
          );
        },
      ),
    );
  }
}
