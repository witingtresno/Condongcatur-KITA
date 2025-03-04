import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LembagaMenu extends StatefulWidget {
  const LembagaMenu({super.key});

  @override
  State<LembagaMenu> createState() => _LembagaMenuState();
}

class _LembagaMenuState extends State<LembagaMenu> {
  final List<Map<String, dynamic>> layananMenu = [
    {
      'title': 'Pemberdayaan Kesejahteraan Keluarga',
      'icon': Icons.family_restroom_rounded,
      'color': Config.cardColor,
      'route': CustomRoute.pkk
    },
    {
      'title': 'RT/RW',
      'icon': Icons.people_sharp,
      'color': Config.cardColor,
      'route': CustomRoute.rtrw
    },
    {
      'title': 'LINMAS',
      'icon': Icons.reduce_capacity_sharp,
      'color': Config.cardColor,
      'route': CustomRoute.linmas
    },
    {
      'title': 'LPMKAL',
      'icon': Icons.account_balance,
      'color': Config.cardColor,
      'route': CustomRoute.lpmkal
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'Lembaga',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: layananMenu.length,
        itemBuilder: (context, index) {
          final layanan = layananMenu[index];
          return buildLayananItem(
            context,
            title: layanan['title'],
            icon: layanan['icon'],
            color: layanan['color'],
            onTap: () {
              // Navigasi ke halaman layanan terkait
              Navigator.pushNamed(context, layanan['route']);
            },
          );
        },
      ),
    );
  }

  Widget buildLayananItem(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.roboto(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
