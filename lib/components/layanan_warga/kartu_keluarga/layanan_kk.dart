import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KKMenuScreen extends StatelessWidget {
  const KKMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> kkMenu = [
      {'title': 'KK Baru', 'route': CustomRoute.kkBaru},
      {'title': 'KK Perubahan data', 'route': CustomRoute.kkPerubahan},
      {'title': 'KK Penambahan/Pengurangan Jiwa', 'route': CustomRoute.kkJiwa},
      {'title': 'KK Hilang', 'route': CustomRoute.kkHilang},
    ];

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
      body: ListView.separated(
        itemCount: kkMenu.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey,
        ),
        itemBuilder: (context, index) {
          final item = kkMenu[index];
          return ListTile(
            title: Text(
              item['title'],
              style: GoogleFonts.roboto(
                color: Colors.black,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                item['route'],
              );
            },
          );
        },
      ),
    );
  }
}
