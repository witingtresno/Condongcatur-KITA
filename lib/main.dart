import 'package:desa_gempol/components/ajukan_layanan/ajukan_layanan.dart';
import 'package:desa_gempol/components/announcement/detail_pemberitahuan.dart';
import 'package:desa_gempol/components/announcement/pemberitahuan.dart';
import 'package:desa_gempol/components/auth/login.dart';
import 'package:desa_gempol/components/auth/register.dart';
import 'package:desa_gempol/components/daftar_nomor_darurat/daftar_nomor_darurat.dart';
import 'package:desa_gempol/components/forum/create_forum.dart';
import 'package:desa_gempol/components/forum/edit_forum.dart';
import 'package:desa_gempol/components/layanan_warga/akta_kelahiran/akta_kelahiran.dart';
import 'package:desa_gempol/components/layanan_warga/akta_kematian/akta_kematian.dart';
import 'package:desa_gempol/components/layanan_warga/domisili_perusahaan/domisili_perusahaan.dart';
import 'package:desa_gempol/components/layanan_warga/harga_tanah/harga_tanah.dart';
import 'package:desa_gempol/components/layanan_warga/kartu_keluarga/layanan/kk_baru.dart';
import 'package:desa_gempol/components/layanan_warga/kartu_keluarga/layanan/kk_hilang.dart';
import 'package:desa_gempol/components/layanan_warga/kartu_keluarga/layanan/kk_penambahan_pengurangan.dart';
import 'package:desa_gempol/components/layanan_warga/kartu_keluarga/layanan/kk_perubahan_data.dart';
import 'package:desa_gempol/components/layanan_warga/kartu_keluarga/layanan_kk.dart';
import 'package:desa_gempol/components/layanan_warga/ket_belum_menikah/ket_belum_menikah.dart';
import 'package:desa_gempol/components/layanan_warga/ktp/ktp_screen.dart';
import 'package:desa_gempol/components/layanan_warga/ktp/layanan/ktp_baru.dart';
import 'package:desa_gempol/components/layanan_warga/ktp/layanan/ktp_hilang.dart';
import 'package:desa_gempol/components/layanan_warga/nikah/nikah_menu.dart';
import 'package:desa_gempol/components/layanan_warga/nikah/sub_nikah/nikah_non_muslim.dart';
import 'package:desa_gempol/components/layanan_warga/nikah/sub_nikah/nikah_perempuan.dart';
import 'package:desa_gempol/components/layanan_warga/nikah/sub_nikah/nikah_pria.dart';
import 'package:desa_gempol/components/layanan_warga/penghasilan/penghasilan.dart';
import 'package:desa_gempol/components/layanan_warga/perijinan/menu_perijinan.dart';
import 'package:desa_gempol/components/layanan_warga/perijinan/sub_menu/ijin_keramaian.dart';
import 'package:desa_gempol/components/layanan_warga/perijinan/sub_menu/ijin_penelitian.dart';
import 'package:desa_gempol/components/layanan_warga/perijinan/sub_menu/imb.dart';
import 'package:desa_gempol/components/layanan_warga/perijinan/sub_menu/iumk.dart';
import 'package:desa_gempol/components/layanan_warga/pindah_penduduk/layanan/pindah_datang.dart';
import 'package:desa_gempol/components/layanan_warga/pindah_penduduk/layanan/pindah_keluar.dart';
import 'package:desa_gempol/components/layanan_warga/proposal/proposal.dart';
import 'package:desa_gempol/components/layanan_warga/skck/skck.dart';
import 'package:desa_gempol/components/layanan_warga/skm/ket_miskin.dart';
import 'package:desa_gempol/components/layanan_warga/sku/sku.dart';
import 'package:desa_gempol/components/layanan_warga/talak_gugat_cerai/talak_gugat_cerai.dart';
import 'package:desa_gempol/components/lembaga/lembaga_menu.dart';
import 'package:desa_gempol/components/lembaga/linmas/linmas.dart';
import 'package:desa_gempol/components/lembaga/lpmkal/lpmkal.dart';
import 'package:desa_gempol/components/lembaga/pkk/pkk.dart';
import 'package:desa_gempol/components/lembaga/rt_rw/rt_rw.dart';
import 'package:desa_gempol/components/news/detail_news.dart';
import 'package:desa_gempol/components/forum/forum.dart';
import 'package:desa_gempol/components/gallery/detail_gallery.dart';
import 'package:desa_gempol/components/gallery/gallery.dart';
import 'package:desa_gempol/components/layanan_warga/layanan_warga.dart';
import 'package:desa_gempol/components/layanan_warga/pindah_penduduk/pindah.dart';
import 'package:desa_gempol/components/potensi_desa/detail_potensi_desa.dart';
import 'package:desa_gempol/components/potensi_desa/potensi_desa.dart';
import 'package:desa_gempol/components/privacy_policy/privacy_policy.dart';
import 'package:desa_gempol/components/program_desa/program_desa.dart';
import 'package:desa_gempol/components/ulasan/add_ulasan.dart';
import 'package:desa_gempol/components/ulasan/ulasan.dart';
import 'package:desa_gempol/components/view_web/daftar_pejabat.dart';
import 'package:desa_gempol/components/view_web/profile_screen.dart';
import 'package:desa_gempol/main_navigation.dart';
import 'package:desa_gempol/provider/ajukan_layanan/ajukan_layanan_provider.dart';
import 'package:desa_gempol/provider/ajukan_layanan/respone_ajukan.dart';
import 'package:desa_gempol/provider/announcement/announce_provider.dart';
import 'package:desa_gempol/provider/auth/auth_provider.dart';
import 'package:desa_gempol/provider/forum/forum_provider.dart';
import 'package:desa_gempol/provider/gallery/gallery_provider.dart';
import 'package:desa_gempol/provider/news/news_provider.dart';
import 'package:desa_gempol/provider/potensi_desa/potensi_desa.dart';
import 'package:desa_gempol/provider/ulasan/ulasan.dart';
import 'package:desa_gempol/screen/announcement_screen.dart';
import 'package:desa_gempol/screen/home_screen.dart';
import 'package:desa_gempol/screen/profile.dart';
import 'package:desa_gempol/splash_screen.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/news/berita_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsProvider()),
        ChangeNotifierProvider(create: (context) => GalleryProvider()),
        ChangeNotifierProvider(create: (context) => AnnounceProvider()),
        ChangeNotifierProvider(create: (context) => PotensiDesa()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AjukanLayananProvider()),
        ChangeNotifierProvider(create: (context) => ResponeAjukan()),
        ChangeNotifierProvider(create: (context) => ForumProvider()),
        ChangeNotifierProvider(create: (context) => UlasanProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: CustomRoute.splashScreen,
        routes: {
          CustomRoute.splashScreen: (context) => const SplashScreen(),
          CustomRoute.registerScreen: (context) => const RegisterPage(),
          CustomRoute.main: (context) => const MainNavigation(),
          CustomRoute.homeScreen: (context) => const HomeScreen(),
          CustomRoute.profile: (context) => const Profile(),
          CustomRoute.loginScreen: (context) => const LoginPage(),
          CustomRoute.ajukan: (context) => const AjukanLayananScreen(),

          CustomRoute.announcement: (context) => const AnnouncementScreen(),

          //   Components

          //Berita
          CustomRoute.beritaScreen: (context) => const BeritaScreen(),
          CustomRoute.detailBeritaScreen: (context) =>
              const DetailBeritaScreen(),

          //Gallery
          CustomRoute.gallery: (context) => const GalleryScreen(),
          CustomRoute.detailGallery: (context) => const DetailGalleryScreen(),

          //announce
          CustomRoute.pemberitahuan: (context) => const Pemberitahuan(),
          CustomRoute.detailPemberitahuan: (context) =>
              const DetailPemberitahuan(),

          // layanan warga
          CustomRoute.layananWarga: (context) => const LayananWarga(),

          // sub layanan warga
          CustomRoute.pindah: (context) => const Pindah(),
          // sub layanan pindah
          CustomRoute.pindahKeluar: (context) => const PindahKeluar(),
          CustomRoute.pindahDatang: (context) => const PindahDatang(),

          // layanan KK
          CustomRoute.layananKK: (context) => const KKMenuScreen(),

          // sub layanan KK
          CustomRoute.kkBaru: (context) => const KKBaru(),
          CustomRoute.kkHilang: (context) => const KKHilangScreen(),
          CustomRoute.kkPerubahan: (context) => const KKPerubahanData(),
          CustomRoute.kkJiwa: (context) => const KKPenambahanPengurangan(),

          // KTP
          CustomRoute.ktp: (context) => const KtpScreen(),
          // SUB KTP
          CustomRoute.ktpBaru: (context) => const KtpBaru(),
          CustomRoute.ktpHilang: (context) => const KtpHilang(),

          // Akte
          CustomRoute.akte: (context) => const AktaKelahiran(),
          CustomRoute.akteMati: (context) => const AktaKematian(),

          // NIKAH
          CustomRoute.nikahMenu: (context) => const NikahMenu(),
          // Sub Nikah
          CustomRoute.nikahPria: (context) => const NikahPria(),
          CustomRoute.nikahPerempuan: (context) => const NikahPerempuan(),
          CustomRoute.nikahNonMuslim: (context) => const NikahNonMuslim(),

          // SKCK
          CustomRoute.skck: (context) => const Skck(),

          // Perijinan
          // CustomRoute.perijinan : (context) => (),

          // ket belum nikah
          CustomRoute.ketBelumMenikah: (context) => const KetBelumMenikah(),

          // SKM
          CustomRoute.suratKetMiskin: (context) => const KetMiskin(),

          // Penghasilan
          CustomRoute.penghasilan: (context) => const Penghasilan(),

          // Talak
          CustomRoute.talakOrGugatCerai: (context) => const TalakGugatCerai(),

          // proposal
          CustomRoute.proposal: (context) => const Proposal(),

          // SKU
          CustomRoute.sku: (context) => const Sku(),

          // Harga Tanah
          CustomRoute.hargaTanah: (context) => const HargaTanah(),

          // Domisili Perusahaan
          CustomRoute.domPerusahaan: (context) => const DomisiliPerusahaan(),

          // potensi desa
          CustomRoute.potensiDesa: (context) => const PotensiDesaScreen(),
          CustomRoute.detaiPotensiDesa: (context) => const DetailDesaScreen(),

          // Perijinan
          CustomRoute.menuPerijinan: (context) => const MenuPerijinan(),
          CustomRoute.ijinKeramaian: (context) => const IjinKeramaian(),
          CustomRoute.ijinPenelitian: (context) => const IjinPenelitian(),
          CustomRoute.imb: (context) => const Imb(),
          CustomRoute.iumk: (context) => const Iumk(),

          CustomRoute.forumWarga: (context) => const ForumDesaScreen(),
          CustomRoute.createAjuan: (context) => const CreateAduanScreen(),
          CustomRoute.editForum: (context) => const EditForum(),

          CustomRoute.profileScreen: (context) => const ProfileScreen(),
          CustomRoute.daftarPejabat: (context) => const DaftarPejabat(),

          CustomRoute.detailNomor: (context) => const DaftarNomorDarurat(),

          CustomRoute.privacyPolicy: (context) => const PrivacyPolicy(),

          CustomRoute.programDesa: (context) => const ProgramDesa(),

          // Lembaga
          CustomRoute.lembaga: (context) => const LembagaMenu(),
          CustomRoute.pkk: (context) => const Pkk(),
          CustomRoute.rtrw: (context) => const RtRw(),
          CustomRoute.linmas: (context) => const Linmas(),
          CustomRoute.lpmkal: (context) => const Lpmkal(),

          CustomRoute.ulasan: (context) => const UlasanScreen(),
          CustomRoute.addUlasan: (context) => const AddUlasanScreen(),
        },
      ),
    );
  }
}
