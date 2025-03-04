import 'package:cached_network_image/cached_network_image.dart';
import 'package:desa_gempol/model/news/get_news.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/provider/news/news_provider.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BeritaScreen extends StatefulWidget {
  const BeritaScreen({super.key});

  @override
  State<BeritaScreen> createState() => _BeritaScreenState();
}

class _BeritaScreenState extends State<BeritaScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<NewsProvider>(context, listen: false).getNews();
    });
  }

  Future<void> _refreshData() async {
    await Provider.of<NewsProvider>(context, listen: false).getNews();
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
          'BERITA DESA',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Consumer<NewsProvider>(
          builder: (context, newsProvider, _) {
            return dataStateHandler<GetNews>(
              status: newsProvider.stateNews!,
              onSucces: (value) {
                if (value == null || value.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.info, size: 50, color: Colors.blueGrey),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada berita.',
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
                            const Icon(Icons.error, size: 80),
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
                                Text(
                                  item.description ?? 'Tidak ada deskripsi',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: Colors.grey[800],
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
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          CustomRoute.detailBeritaScreen,
                                          arguments: {
                                            'idNews': item.id.toString()
                                          },
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        backgroundColor: Config.cardColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
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
