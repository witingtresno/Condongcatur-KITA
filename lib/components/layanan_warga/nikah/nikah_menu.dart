import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NikahMenu extends StatelessWidget {
  const NikahMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> nikahMenu = [
      {'title': 'Nikah Laki - Laki', 'route': CustomRoute.nikahPria},
      {'title': 'Nikah Perempuan', 'route': CustomRoute.nikahPerempuan},
      {'title': 'Nikah Non Muslim', 'route': CustomRoute.nikahNonMuslim},
    ];
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'LAYANAN',
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: ListView.separated(
        itemCount: nikahMenu.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey,
        ),
        itemBuilder: (context, index) {
          final item = nikahMenu[index];
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
