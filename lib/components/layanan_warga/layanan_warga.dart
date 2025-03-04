import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:heroicons/heroicons.dart';

class LayananWarga extends StatefulWidget {
  const LayananWarga({super.key});

  @override
  State<LayananWarga> createState() => _LayananWargaState();
}

class _LayananWargaState extends State<LayananWarga> {
  final List<Map<String, dynamic>> layananOrang = [
    {
      'title': 'Pindah Penduduk',
      'icon': HeroIcons.userGroup,
      'color': Config.cardColor,
      'route': CustomRoute.pindah
    },
    {
      'title': 'Kartu Keluarga',
      'icon': HeroIcons.documentText,
      'color': Config.cardColor,
      'route': CustomRoute.layananKK
    },
    {
      'title': 'KTP',
      'icon': HeroIcons.identification,
      'color': Config.cardColor,
      'route': CustomRoute.ktp
    },
    {
      'title': 'Akta Kelahiran',
      'icon': HeroIcons.sparkles,
      'color': Config.cardColor,
      'route': CustomRoute.akte
    },
    {
      'title': 'Akta Kematian',
      'icon': HeroIcons.eyeSlash,
      'color': Config.cardColor,
      'route': CustomRoute.akteMati
    },
    {
      'title': 'SKCK',
      'icon': HeroIcons.shieldCheck,
      'color': Config.cardColor,
      'route': CustomRoute.skck
    },
    {
      'title': 'Perizinan',
      'icon': HeroIcons.documentCheck,
      'color': Config.cardColor,
      'route': CustomRoute.menuPerijinan
    },
    {
      'title': 'Nikah',
      'icon': HeroIcons.heart,
      'color': Config.cardColor,
      'route': CustomRoute.nikahMenu
    },
    {
      'title': 'Keterangan Belum Menikah',
      'icon': HeroIcons.userMinus,
      'color': Config.cardColor,
      'route': CustomRoute.ketBelumMenikah
    },
    {
      'title': 'Surat Keterangan Miskin',
      'icon': HeroIcons.documentText,
      'color': Config.cardColor,
      'route': CustomRoute.suratKetMiskin
    },
    {
      'title': 'Penghasilan',
      'icon': HeroIcons.banknotes,
      'color': Config.cardColor,
      'route': CustomRoute.penghasilan
    },
    {
      'title': 'Talak / Gugat Cerai',
      'icon': HeroIcons.users,
      'color': Config.cardColor,
      'route': CustomRoute.talakOrGugatCerai
    },
    {
      'title': 'Proposal',
      'icon': HeroIcons.documentDuplicate,
      'color': Config.cardColor,
      'route': CustomRoute.proposal
    },
    {
      'title': 'Surat Keterangan Usaha',
      'icon': HeroIcons.buildingOffice2,
      'color': Config.cardColor,
      'route': CustomRoute.sku
    },
    {
      'title': 'Harga Tanah',
      'icon': HeroIcons.mapPin,
      'color': Config.cardColor,
      'route': CustomRoute.hargaTanah
    },
    {
      'title': 'Domisili Perusahaan',
      'icon': HeroIcons.homeModern,
      'color': Config.cardColor,
      'route': CustomRoute.domPerusahaan
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 4 : 2;
    final childAspectRatio = screenWidth > 600 ? 1.8 : 1.3;

    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'Layanan Warga',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Config.cardColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Kurangi padding dari 16 ke 8
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 5, // Kurangi jarak horizontal
            mainAxisSpacing: 5, // Kurangi jarak vertikal
            childAspectRatio: childAspectRatio,
          ),
          itemCount: layananOrang.length,
          itemBuilder: (context, index) {
            final layanan = layananOrang[index];
            return _buildLayananItem(
              context,
              title: layanan['title'],
              icon: layanan['icon'],
              color: layanan['color'],
              onTap: () {
                Navigator.pushNamed(context, layanan['route']);
              },
            );
          },
        ),
      ),
    );
  }

        Widget _buildLayananItem(BuildContext context, {
    required String title,
    required HeroIcons icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: HeroIcon(
                icon,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}