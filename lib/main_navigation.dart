import 'dart:math';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:desa_gempol/provider/auth/auth_provider.dart';
import 'package:desa_gempol/screen/announcement_screen.dart';
import 'package:desa_gempol/screen/home_screen.dart';
import 'package:desa_gempol/screen/lainnya_screen.dart';
import 'package:desa_gempol/screen/profile.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final PageController _pageController = PageController(initialPage: 0);
  late final NotchBottomBarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = NotchBottomBarController(index: 0);
  }

  @override
  void dispose() {
    // Dispose semua controller dengan benar
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _navigateToPage(int index) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Periksa apakah pengguna sudah login sebelum mengakses Info dan Profile
    if ((index == 1 || index == 2) && !authProvider.isLoggedIn) {
      final loginResult =
      await Navigator.pushNamed(context, CustomRoute.loginScreen);

      // Periksa apakah widget masih aktif sebelum memanggil setState
      if (!mounted) return;

      if (loginResult == true) {
        setState(() {
          _controller.index = index;
          _pageController.jumpToPage(index);
        });
      } else {
        setState(() {
          _controller.index = 0;
          _pageController.jumpToPage(0);
        });
      }
      return;
    }

    // Navigasi ke halaman lain
    if (mounted) {
      setState(() {
        _controller.index = index;
        _pageController.jumpToPage(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      const HomeScreen(),
      const AnnouncementScreen(),
      const Profile(),
      const LainnyaScreen(),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: bottomBarPages,
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.white,
        textOverflow: TextOverflow.ellipsis,
        shadowElevation: 5,
        kBottomRadius: 15.0,
        notchColor: Colors.blue,
        removeMargins: false,
        bottomBarWidth: 800,
        notchShader: SweepGradient(
          startAngle: 0,
          endAngle: pi / 2,
          colors: [
            Colors.blue.shade600,
            Colors.blueAccent.shade700,
            Colors.indigo.shade600,
          ],
          tileMode: TileMode.mirror,
        ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
        itemLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        bottomBarItems: [
          const BottomBarItem(
            inActiveItem:
            HeroIcon(HeroIcons.home, size: 24, color: Colors.blue),
            activeItem:
            HeroIcon(HeroIcons.home, size: 24, color: Colors.white),
            itemLabel: 'HOME',
          ),
          const BottomBarItem(
            inActiveItem: HeroIcon(HeroIcons.informationCircle,
                size: 24, color: Colors.blue),
            activeItem: HeroIcon(HeroIcons.informationCircle,
                size: 24, color: Colors.white),
            itemLabel: 'INFO',
          ),
          BottomBarItem(
            inActiveItem: const HeroIcon(HeroIcons.user, size: 24, color: Colors.blue),
            activeItem: const HeroIcon(HeroIcons.user, size: 24, color: Colors.white),
            itemLabel: Provider.of<AuthProvider>(context, listen: true).isLoggedIn
                ? (Provider.of<AuthProvider>(context, listen: true)
                .userNow
                ?.name
                ?.split(' ')
                .first ??
                'PROFILE')
                .substring(
              0,
              (Provider.of<AuthProvider>(context, listen: true)
                  .userNow
                  ?.name
                  ?.split(' ')
                  .first ??
                  'PROFILE')
                  .length
                  .clamp(0, 10),
            ) // Clamp digunakan untuk mencegah RangeError
                : 'PROFILE',
          ),

          const BottomBarItem(
            inActiveItem: HeroIcon(HeroIcons.ellipsisHorizontalCircle,
                size: 24, color: Colors.blue),
            activeItem: HeroIcon(HeroIcons.ellipsisHorizontalCircle,
                size: 24, color: Colors.white),
            itemLabel: 'LAINNYA',
          ),
        ],
        onTap: _navigateToPage,
        kIconSize: 24.0,
      ),
    );
  }
}