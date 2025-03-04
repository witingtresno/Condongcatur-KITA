import 'dart:io';
import 'package:desa_gempol/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class DaftarNomorDarurat extends StatefulWidget {
  const DaftarNomorDarurat({super.key});

  @override
  State<DaftarNomorDarurat> createState() => _DaftarNomorDaruratState();
}

class _DaftarNomorDaruratState extends State<DaftarNomorDarurat> {
  String? _localFilePath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _downloadAndSavePDF();
  }

  Future<void> _downloadAndSavePDF() async {
    const String url =
        'https://www.dprd-diy.go.id/wp-content/uploads/2015/04/Telepon-Darurat-Jogja.pdf';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/nomor_darurat.pdf');
        await file.writeAsBytes(bytes, flush: true);

        setState(() {
          _localFilePath = file.path;
          _isLoading = false;
        });
      } else {
        throw Exception('Gagal mengunduh file PDF.');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'Daftar Nomor Darurat',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _localFilePath == null
              ? const Center(child: Text('Gagal memuat file PDF'))
              : PDFView(
                  filePath: _localFilePath!,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: true,
                  pageFling: true,
                  onRender: (pages) {
                    setState(() {});
                  },
                  onError: (error) {},
                  onPageError: (page, error) {},
                ),
    );
  }
}
