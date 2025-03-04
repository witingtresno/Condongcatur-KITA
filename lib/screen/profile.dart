import 'package:desa_gempol/provider/auth/auth_provider.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    final user = auth.userNow;
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          "PROFILE",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Config.cardColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? "Nama tidak tersedia",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "NIK: ${user?.nik ?? "Tidak tersedia"}",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    // Text(
                    //   "Alamat: ${user?.address ?? "Tidak tersedia"}",
                    //   style: GoogleFonts.poppins(fontSize: 14),
                    // ),
                    // Text(
                    //   "Pedukuhan: ${user?.hamlet?.name ?? "Tidak tersedia"}",
                    //   style: GoogleFonts.poppins(fontSize: 14),
                    // ),
                    // Text(
                    //   "RT: ${user?.hamlet?.rt ?? "Tidak tersedia"}",
                    //   style: GoogleFonts.poppins(fontSize: 14),
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, CustomRoute.ajukan);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Config.cardColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.send, color: Colors.white,),
                  const SizedBox(width: 8),
                  Text(
                    "AJUKAN PELAYANAN",
                    style: GoogleFonts.roboto(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  auth.logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (Route<dynamic> route) => false);
                },
                child: Text(
                  "LOGOUT",
                  style: GoogleFonts.roboto(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
