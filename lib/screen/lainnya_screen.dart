import 'package:desa_gempol/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../utils/custom_route.dart';

class LainnyaScreen extends StatelessWidget {
  const LainnyaScreen({super.key});

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'title': 'Profil Desa',
        'icon': HeroIcons.home,
        'color': Config.cardColor,
        'route': CustomRoute.profileScreen,
      },
      {
        'title': 'Lembaga',
        'icon': HeroIcons.buildingOffice,
        'color': Config.cardColor,
        'route': CustomRoute.lembaga,
      },
      {
        'title': 'Data Desa',
        'icon': HeroIcons.chartBar,
        'color': Config.cardColor,
        'route': CustomRoute.daftarPejabat,
      },
      {
        'title': 'Pengaduan',
        'icon': HeroIcons.archiveBox,
        'color': Config.cardColor,
        'route': CustomRoute.forumWarga,
      },
      {
        'title': 'Privacy Policy',
        'color': Config.cardColor,
        'icon': HeroIcons.shieldCheck,
        'route': CustomRoute.privacyPolicy,
      },
      {
        'title': 'Nomor Darurat',
        'icon': HeroIcons.phoneArrowUpRight,
        'color': Config.cardColor,
        'route': CustomRoute.detailNomor,
      },
      {
        'title': 'Ulasan',
        'icon': HeroIcons.star,
        'color': Config.cardColor,
        'route': CustomRoute.ulasan,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LAINNYA',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        backgroundColor: Config.cardColor,
        centerTitle: true,
      ),
      backgroundColor: Config.primaryColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, item['route'] as String);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: item['color'] as Color,
                                shape: BoxShape.circle,
                              ),
                              child: HeroIcon(
                                item['icon'] as HeroIcons,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item['title'] as String,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: FutureBuilder<String>(
              future: getAppVersion(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                return Text(
                  'Versi ${snapshot.data ?? '1.0.0'}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
