import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pindah extends StatefulWidget {
  const Pindah({super.key});

  @override
  State<Pindah> createState() => _PindahState();
}

class _PindahState extends State<Pindah> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuPindah = [
      {'title': 'Pindah Keluar', 'route': CustomRoute.pindahKeluar},
      {'title': 'Pindah Datang', 'route': CustomRoute.pindahDatang},
    ];
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'LAYANAN',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: ListView.separated(
        itemCount: menuPindah.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey,
        ),
        itemBuilder: (context, index) {
          final item = menuPindah[index];
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
