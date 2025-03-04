import 'package:desa_gempol/model/ajukan_layanan/ajukan_layanan.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/repository/api.dart';
import 'package:flutter/material.dart';

class AjukanLayananProvider with ChangeNotifier {
  DataStateModel<AjukanLayanan> layananState =
      DataStateModel(status: StateStatus.idle);
  String? selectedHamlet;
  String? _message;
  bool _isHamletInitialized = false;

  String? get message => _message;

  // Method untuk mengubah pesan
  void setMessage(String? newMessage) {
    _message = newMessage;
    notifyListeners();
  }

  void selectHamlet(String hamletName) {
    selectedHamlet = hamletName; // Update nama pedukuhan terpilih
    notifyListeners();
  }

  void initializeHamlet(String hamlet) {
    if (!_isHamletInitialized) {
      selectedHamlet = hamlet;
      _isHamletInitialized = true;
      notifyListeners();
    }
  }

  // Fungsi untuk mengirim data pengajuan
  Future<void> submitLayanan({
    required String nikId,
    required String title,
    required String requisite,
    required String hamletId,
  }) async {
    layananState = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      final result = await Api.addSubmission(
        nikId: nikId,
        title: title,
        hamletName: hamletId,
        requisite: requisite,
      );
      layananState = DataStateModel(status: StateStatus.succes, data: result);
      notifyListeners();
    } catch (e) {
      layananState =
          DataStateModel(status: StateStatus.error, errMessage: e.toString());
      notifyListeners();
    }
  }

  bool validateForm(
      String nikId, String title, String requisite, String? selectedHamlet) {
    if (nikId.isEmpty ||
        nikId.length != 16 ||
        !RegExp(r'^\d+$').hasMatch(nikId)) {
      setMessage("NIK harus terdiri dari 16 digit angka.");
      return false;
    }
    if (title.isEmpty) {
      setMessage("Judul Pengajuan tidak boleh kosong.");
      return false;
    }
    if (requisite.isEmpty) {
      setMessage("Persyaratan tidak boleh kosong.");
      return false;
    }
    if (selectedHamlet == null || selectedHamlet.isEmpty) {
      setMessage("Pilih salah satu pedukuhan.");
      return false;
    }
    setMessage(null); // Reset pesan jika validasi berhasil
    return true;
  }
}
