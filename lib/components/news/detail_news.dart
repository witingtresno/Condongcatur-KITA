import 'package:desa_gempol/model/news/get_detail_news.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:desa_gempol/provider/news/news_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailBeritaScreen extends StatefulWidget {
  const DetailBeritaScreen({super.key});

  @override
  State<DetailBeritaScreen> createState() => _DetailBeritaScreenState();
}

class _DetailBeritaScreenState extends State<DetailBeritaScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final idNews = arguments['idNews'] as String;
      Provider.of<NewsProvider>(context, listen: false)
          .getDetailNews(idNews: idNews);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'Berita',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, _) {
          return dataStateHandler<GetDetailNews>(
            status: newsProvider.stateDetailNews!,
            onSucces: (value) {
              final detail = value!.data!;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar Berita
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        detail.image!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image, size: 50),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Judul Berita
                    Text(
                      detail.title!,
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Deskripsi Berita
                    Text(
                      detail.description!,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              );
            },
            onFailed: (errMessage) {
              return Center(
                child: Text(
                  errMessage.toString(),
                  style: GoogleFonts.roboto(color: Colors.red),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
