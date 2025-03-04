import 'package:cached_network_image/cached_network_image.dart';
import 'package:desa_gempol/provider/potensi_desa/potensi_desa.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:desa_gempol/provider/news/news_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() {
        final newsProvider = Provider.of<NewsProvider>(context, listen: false);
        final potensiProvider = Provider.of<PotensiDesa>(context, listen: false);
        newsProvider.getNews(); // Fetch berita dari provider
        potensiProvider.getPotensi(); // Fetch potensi desa dari provider
      });
    });
  }

  Future<void> _refreshData() async {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    final potensiProvider = Provider.of<PotensiDesa>(context, listen: false);
    await Future.wait([
      newsProvider.getNews(),
      potensiProvider.getPotensi(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        backgroundColor: Config.primaryColor,
        elevation: 0,
        title: Row(
          children: [
            ClipRRect(
              child: Image.asset(
                'assets/lambang.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SISTEM INFORMASI & ADMINISTRASI',
                    style: GoogleFonts.roboto(
                      color: Config.cardColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Kelurahan CondongCatur',
                    style: GoogleFonts.roboto(
                      color: Config.cardColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(), // Pastikan bisa di-scroll
          padding: const EdgeInsets.all(10),
          children: [
            _buildCarouselBerita(),
            const SizedBox(height: 20),
            _buildUcapanSelamatDatang(),
            const SizedBox(height: 20),
            _buildGridLayanan(),
            const SizedBox(height: 20), // Placeholder agar bisa di-scroll
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselBerita() {
    return Consumer<NewsProvider>(
      builder: (context, newsProvider, child) {
        final newsList = newsProvider.stateNews?.data?.data ?? [];
        if (newsList.isEmpty) {
          return Container(
            height: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Tidak ada berita",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }
        return SizedBox(
          height: 200,
          child: PageView.builder(
            itemCount: newsList.length,
            controller: PageController(viewportFraction: 1.0),
            itemBuilder: (context, index) {
              final news = newsList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    CustomRoute.detailBeritaScreen,
                    arguments: {'idNews': news.id.toString()},
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: news.image ?? '',
                          placeholder: (context, url) =>
                          const Center(
                            child: SpinKitThreeBounce(
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(
                            Icons.broken_image,
                            size: 80,
                          ),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            color: Colors.black.withOpacity(0.5),
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              news.title ?? "Tanpa Judul",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildUcapanSelamatDatang() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        'Selamat Datang di Sistem Informasi dan Administrasi Kelurahan Condongcatur',
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildGridLayanan() {
    final menuItems = [
      {
        'title': 'Layanan Warga',
        'icon': HeroIcons.documentText,
        'color': Config.cardColor,
        'route': CustomRoute.layananWarga,
      },
      {
        'title': 'Berita',
        'icon': HeroIcons.newspaper,
        'color': Config.cardColor,
        'route': CustomRoute.beritaScreen,
      },
      {
        'title': 'Pemberitahuan',
        'icon': HeroIcons.bellAlert,
        'color': Config.cardColor,
        'route': CustomRoute.pemberitahuan,
      },
      {
        'title': 'Potensi Desa',
        'icon': HeroIcons.buildingOffice,
        'color': Config.cardColor,
        'route': CustomRoute.potensiDesa,
      },
      {
        'title': 'Gallery',
        'icon': HeroIcons.photo,
        'color': Config.cardColor,
        'route': CustomRoute.gallery,
      },
      {
        'title': 'Program Desa',
        'icon': HeroIcons.buildingLibrary,
        'color': Config.cardColor,
        'route': CustomRoute.programDesa,
      },
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 1.7,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, item['route'] as String);
          },
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
              const SizedBox(height: 10),
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
        );
      },
    );
  }
}
