import 'package:desa_gempol/provider/auth/auth_provider.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NikahPria extends StatelessWidget {
  const NikahPria({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'LAYANAN',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nikah Laki - Laki',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Persyaratan:',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '1. Fotokopi KTP Kedua Calon Mempelai\n'
                    '2. FotoKopi KTP Orang Tua Kedua Calon Mempelai\n'
                    '3. Fotokopi C1 (Kartu Keluarga) Kedua Calon Mempelai\n'
                    '4. Fotokopi Akta Kelahiran Kedua Calon Mempelai\n'
                    '5. Fotokopi Ijazah Non Sarjana\n'
                    '6. Pas Photo (berwarna biru) Kedua Calon Mempelai :\n'
                    '  a. Ukuran 2x3 = 6 lembar\n'
                    '  b. Ukuran 4x6 = 1 lembar\n',
                    style: GoogleFonts.roboto(fontSize: 14),
                  ),
                ],
              ),
            ),
            const Spacer(),
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
                        final loginResult = await Navigator.pushNamed(
                            context, CustomRoute.loginScreen);

                        // Jika login berhasil, lanjutkan ke halaman Ajukan
                        if (loginResult == true) {
                          Navigator.pushNamed(context, CustomRoute.ajukan);
                        } else {
                          // Jika login dibatalkan, tampilkan pesan dan tetap di halaman ini
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Anda harus login untuk mengajukan pelayanan.'),
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
