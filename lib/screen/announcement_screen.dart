import 'package:desa_gempol/model/ajukan_layanan/get_response.dart';
import 'package:desa_gempol/provider/ajukan_layanan/respone_ajukan.dart';
import 'package:desa_gempol/provider/auth/auth_provider.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<ResponeAjukan>(context, listen: false).fetchPermohonan();
      }
    });
  }

  Future<void> _refreshData() async {
    await Provider.of<ResponeAjukan>(context, listen: false).fetchPermohonan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          "PENGAJUAN SAYA",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Config.cardColor,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Consumer2<ResponeAjukan, AuthProvider>(
          builder: (context, provider, authProvider, _) {
            return dataStateHandler<GetResponse>(
              status: provider.statePermohonan!,
              onSucces: (value) {
                if (value == null || value.data!.isEmpty) {
                  return _buildNoDataView();
                }

                // **Filter hanya permohonan milik user yang sedang login**
                final userPermohonan = value.data!.where(
                      (permohonan) => permohonan.user?.id == authProvider.userNow?.idUser,
                ).toList();

                if (userPermohonan.isEmpty) {
                  return _buildNoDataView();
                }

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: userPermohonan.length,
                  itemBuilder: (context, index) {
                    final permohonan = userPermohonan[index];
                    return _buildPermohonanCard(permohonan);
                  },
                );
              },
              onFailed: (err) => _buildErrorView(err),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNoDataView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info, size: 50, color: Colors.blueGrey),
          const SizedBox(height: 16),
          Text(
            'Belum ada permohonan',
            style: GoogleFonts.roboto(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String? err) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 50, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Gagal memuat data: $err',
            style: GoogleFonts.roboto(fontSize: 16, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPermohonanCard(dynamic permohonan) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                permohonan.title ?? "Tidak ada judul",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Tanggal Pengajuan : ${permohonan.date ?? "Tidak ada tanggal"}",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(
                "NIK: ${permohonan.user?.nik ?? "Tidak diketahui"}",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Text(
                "Status Pengajuan: ${permohonan.status ?? "Tidak diketahui"}",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: _getStatusColor(permohonan.status),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    if (status == null) return Colors.blueAccent;
    switch (status.toLowerCase()) {
      case "diterima":
        return Colors.green;
      case "ditolak":
        return Colors.red;
      default:
        return Colors.blueAccent;
    }
  }
}
