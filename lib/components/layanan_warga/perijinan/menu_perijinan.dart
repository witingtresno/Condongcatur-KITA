import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPerijinan extends StatefulWidget {
  const MenuPerijinan({super.key});

  @override
  State<MenuPerijinan> createState() => _MenuPerijinanState();
}

class _MenuPerijinanState extends State<MenuPerijinan> {
  final List<Map<String, dynamic>> menuPerijinan = [
    {'title': 'Ijin Keramaian', 'route': CustomRoute.ijinKeramaian},
    {'title': 'Ijin Penelitian', 'route': CustomRoute.ijinPenelitian},
    {'title': 'Ijin Usaha Mikro dan Kecil (IUMK)', 'route': CustomRoute.iumk},
    {'title': 'Ijin Mendirikan Bangunan (IMB)', 'route': CustomRoute.imb},
  ];

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
      body: ListView.separated(
        itemCount: menuPerijinan.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey,
        ),
        itemBuilder: (context, index) {
          final item = menuPerijinan[index];
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
