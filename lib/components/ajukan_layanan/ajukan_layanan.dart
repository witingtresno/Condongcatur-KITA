import 'package:desa_gempol/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:desa_gempol/model/potensi_desa/get_hamlet.dart';
import 'package:desa_gempol/provider/ajukan_layanan/ajukan_layanan_provider.dart';
import 'package:desa_gempol/provider/auth/auth_provider.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/provider/potensi_desa/potensi_desa.dart';

class AjukanLayananScreen extends StatefulWidget {
  const AjukanLayananScreen({super.key});

  @override
  State<AjukanLayananScreen> createState() => _AjukanLayananScreenState();
}

class _AjukanLayananScreenState extends State<AjukanLayananScreen> {
  final TextEditingController nikController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController requisiteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      // Validasi token JWT
      await authProvider.checkTokenValidity(context);

      final potensiDesaProvider =
          Provider.of<PotensiDesa>(context, listen: false);
      final layananProvider =
          Provider.of<AjukanLayananProvider>(context, listen: false);

      if (potensiDesaProvider.statePotensi?.status == StateStatus.succes &&
          potensiDesaProvider.statePotensi?.data?.data?.isNotEmpty == true) {
        final firstHamlet =
            potensiDesaProvider.statePotensi!.data!.data!.first.name;
        layananProvider.selectHamlet(firstHamlet!);
      }
    });
  }

  Future<void> _submitLayanan() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final layananProvider =
        Provider.of<AjukanLayananProvider>(context, listen: false);

    // Validasi token JWT
    await authProvider.checkTokenValidity(context);

    if (!_formKey.currentState!.validate()) {
      return;
    }

    await layananProvider.submitLayanan(
      nikId: nikController.text,
      title: titleController.text,
      requisite: requisiteController.text,
      hamletId: layananProvider.selectedHamlet!,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          layananProvider.layananState.data?.message ?? "NIK Tidak Terdaftar!",
        ),
        backgroundColor:
            layananProvider.layananState.status == StateStatus.succes
                ? Colors.green
                : Colors.red,
      ),
    );

    if (layananProvider.layananState.status == StateStatus.succes) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final layananProvider =
        Provider.of<AjukanLayananProvider>(context, listen: false);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Config.primaryColor,
        appBar: AppBar(
          title: Text(
            "Ajukan Layanan",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          backgroundColor: Config.cardColor,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildAvatarHeader(),
                      const SizedBox(height: 20),
                      _buildFormCard(layananProvider),
                      const SizedBox(height: 24),
                      _buildSubmitButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.orangeAccent.withOpacity(0.2),
          child:
              const Icon(Icons.assignment, size: 50, color: Config.cardColor),
        ),
        const SizedBox(height: 10),
        Text(
          "Ajukan Layanan Desa",
          style: GoogleFonts.roboto(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 5),
        Text(
          "Lengkapi formulir di bawah ini untuk mengajukan layanan.",
          style: GoogleFonts.roboto(fontSize: 14, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFormCard(AjukanLayananProvider layananProvider) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildValidatedTextField(
              controller: nikController,
              label: "NIK",
              icon: Icons.credit_card,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'NIK tidak boleh kosong';
                }
                if (value.length != 16) {
                  return 'NIK harus 16 digit';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildValidatedTextField(
              controller: titleController,
              label: "Judul Pengajuan",
              icon: Icons.text_fields,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Judul pengajuan tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildValidatedTextField(
              controller: requisiteController,
              label: "Persyaratan",
              icon: Icons.description,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Persyaratan tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildHamletDropdown(layananProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildValidatedTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Config.cardColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent),
      ),
      validator: validator,
    );
  }

  Widget _buildHamletDropdown(AjukanLayananProvider layananProvider) {
    return Consumer<PotensiDesa>(
      builder: (context, potensi, _) {
        return dataStateHandler<GetHamlet>(
          status: potensi.statePotensi!,
          onSucces: (value) {
            return DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.home_work_outlined,
                    color: Config.cardColor),
              ),
              items: value!.data!.map((hamlet) {
                return DropdownMenuItem<String>(
                  value: hamlet.name,
                  child: Text(hamlet.name ?? "Unknown"),
                );
              }).toList(),
              value: layananProvider.selectedHamlet?.isEmpty == true
                  ? null
                  : layananProvider.selectedHamlet,
              onChanged: (selectedHamlet) {
                if (selectedHamlet != null) {
                  layananProvider.selectHamlet(selectedHamlet);
                }
              },
              hint: const Text("Pilih Pedukuhan"),
              validator: (value) {
                if (value == null) {
                  return 'Pilih pedukuhan';
                }
                return null;
              },
            );
          },
          onFailed: (err) {
            return Center(
              child: Text(
                err ?? "Gagal memuat data pedukuhan.",
                style: const TextStyle(color: Colors.red),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton.icon(
      onPressed: _submitLayanan,
      icon: const Icon(
        Icons.send,
        color: Colors.white,
      ),
      label: Text(
        "Ajukan Layanan",
        style: GoogleFonts.roboto(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Config.cardColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
    );
  }
}
