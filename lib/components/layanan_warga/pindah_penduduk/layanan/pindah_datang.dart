import 'package:desa_gempol/provider/auth/auth_provider.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PindahDatang extends StatefulWidget {
  const PindahDatang({super.key});

  @override
  State<PindahDatang> createState() => _PindahDatangState();
}

class _PindahDatangState extends State<PindahDatang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'LAYANAN',
          style: GoogleFonts.roboto(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Informasi Card
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pindah Datang',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Persyaratan:',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'A. PINDAH DATANG ANTAR KAPANEWON\n'
                        '   Langsung datang ke Kapanewon Sewon, membawa:\n'
                        '   1. Surat Pindah WNI dari Kapanewon Asal\n'
                        '   2. Fotokopi Kutipan Akta Nikah\n',
                    style: GoogleFonts.roboto(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'B. PINDAH DATANG ANTAR KABUPATEN/KOTA\n'
                        '   Langsung datang ke Disdukcapil Bantul, membawa:\n'
                        '   1. Surat Pindah WNI dari Kabupaten Asal\n'
                        '   2. Fotokopi Kutipan Akta Nikah\n',
                    style: GoogleFonts.roboto(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Tombol Ajukan Pelayanan
            Consumer<AuthProvider>(
              builder: (context, login, _) {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Config.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      // Periksa apakah pengguna sudah login
                      if (!login.isLoggedIn) {
                        // Jika belum login, arahkan ke halaman login
                        final loginResult = await Navigator.pushNamed(context, CustomRoute.loginScreen);

                        // Jika login berhasil, lanjutkan ke halaman Ajukan
                        if (loginResult == true) {
                          Navigator.pushNamed(context, CustomRoute.ajukan);
                        } else {
                          // Jika login dibatalkan, tampilkan pesan dan tetap di halaman ini
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Anda harus login untuk mengajukan pelayanan.'),
                            ),
                          );
                        }
                      } else {
                        // Jika sudah login, langsung ke halaman Ajukan
                        Navigator.pushNamed(context, CustomRoute.ajukan);
                      }
                    },
                    child: Text(
                      'AJUKAN PELAYANAN',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
