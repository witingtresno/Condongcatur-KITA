import 'package:desa_gempol/provider/auth/auth_provider.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NikahNonMuslim extends StatelessWidget {
  const NikahNonMuslim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'LAYANAN',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
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
                    'Nikah Non Muslim',
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
                    '1. Surat pengantar dari RT dan Dukuh\n'
                    '2. Fotokopi KTP Orang Tua dan Calon Mempelai\n'
                    '3. Fotokopi C1 (Kartu Keluarga)\n'
                    '4. Fotokopi Akta Kelahiran\n'
                    '5. Fotokopi Ijazah (yang ada nama Ayah)\n',
                    style: GoogleFonts.roboto(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '1. Fotokopi Data Diri (KTP/KK) Kedua Orang Tua\n'
                    'dan Kedua Calon Mempelai harap dilampirkan\n'
                    '2. Bagi Calon Mempelai Laki - Laki yang tidak berasal dari\n'
                    'satu lingkup Kecamatan, Surat Rekomendasi dari KUA\n'
                    'Calon Mempelai Laki - Laki harap disertakan\n',
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
