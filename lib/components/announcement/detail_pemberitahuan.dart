import 'package:desa_gempol/model/announcement/get_detail_announcement.dart';
import 'package:desa_gempol/provider/announcement/announce_provider.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../provider/data_state.dart';
import 'package:intl/intl.dart';

class DetailPemberitahuan extends StatefulWidget {
  const DetailPemberitahuan({super.key});

  @override
  State<DetailPemberitahuan> createState() => _DetailPemberitahuanState();
}

class _DetailPemberitahuanState extends State<DetailPemberitahuan> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final idAnnounce = arguments['idAnnounce'].toString();

      Provider.of<AnnounceProvider>(context, listen: false)
          .getDetailAnnounce(idAnnounce: idAnnounce);
    });
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
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: Consumer<AnnounceProvider>(
        builder: (context, announce, _) {
          return dataStateHandler<GetDetailAnnouncement>(
            status: announce.stateDetailAnnounce!,
            onSucces: (value) {
              final detail = value!.data!;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
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
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    // Tanggal dengan ikon kalender
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 20, color: Colors.black),
                        const SizedBox(width: 8),
                        Text(
                          formatTanggal(detail.createdAt!),
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Deskripsi Berita
                    Text(
                      detail.description!,
                      style: GoogleFonts.roboto(
                        fontSize: 20,
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
                  style: const TextStyle(color: Colors.red),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
