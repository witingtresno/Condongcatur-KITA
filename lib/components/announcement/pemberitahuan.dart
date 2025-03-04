import 'package:cached_network_image/cached_network_image.dart';
import 'package:desa_gempol/model/announcement/announcement.dart';
import 'package:desa_gempol/provider/announcement/announce_provider.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../provider/data_state.dart';

class Pemberitahuan extends StatefulWidget {
  const Pemberitahuan({super.key});

  @override
  State<Pemberitahuan> createState() => _PemberitahuantState();
}

class _PemberitahuantState extends State<Pemberitahuan> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<AnnounceProvider>(context, listen: false).getAnnounce();
    });
  }

  Future<void> _refreshData() async {
    await Provider.of<AnnounceProvider>(context, listen: false).getAnnounce();
  }

  String formatTanggal(String rawDate) {
    final DateTime parsedDate = DateTime.parse(rawDate);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'Pemberitahuan',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Consumer<AnnounceProvider>(
          builder: (context, announce, _) {
            return dataStateHandler<Announcement>(
              status: announce.stateAnnounce!,
              onSucces: (value) {
                if (value == null || value.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.info, size: 50, color: Colors.blueGrey),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada pemberitahuan.',
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
                  padding: const EdgeInsets.all(16),
                  itemCount: value.data!.length,
                  itemBuilder: (context, index) {
                    final item = value.data![index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: item.image ?? '',
                            placeholder: (context, url) => const Center(
                              child: SpinKitThreeBounce(
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.broken_image, size: 80),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 180,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title ?? 'Tidak ada judul',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today,
                                            size: 20, color: Colors.black),
                                        const SizedBox(width: 8),
                                        Text(
                                          formatTanggal(item.createdAt ?? ''),
                                          style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          CustomRoute.detailPemberitahuan,
                                          arguments: {
                                            'idAnnounce': item.id.toString()
                                          },
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        backgroundColor: Config.cardColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'READ MORE',
                                        style: GoogleFonts.roboto(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              onFailed: (err) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 50, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Gagal memuat data: $err',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
