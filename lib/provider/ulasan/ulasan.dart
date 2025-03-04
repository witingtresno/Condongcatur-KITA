import 'dart:io';
import 'package:desa_gempol/model/ulasan/get_all_ulasan.dart';
import 'package:desa_gempol/model/ulasan/post_ulasan.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/repository/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:desa_gempol/provider/auth/auth_provider.dart';

class UlasanProvider extends ChangeNotifier {
  DataStateModel<GetAllUlasan>? stateUlasan =
      DataStateModel(status: StateStatus.idle);
  DataStateModel<PostUlasan>? addUlasanState =
      DataStateModel(status: StateStatus.idle);

  /// **Memuat semua ulasan**
  Future<void> getUlasan() async {
    stateUlasan = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      final res = await Api.getAllUlasan();
      stateUlasan = DataStateModel(status: StateStatus.succes, data: res);
    } catch (ex) {
      stateUlasan = DataStateModel(
          status: StateStatus.error, errMessage: 'Gagal mengambil data ulasan');
    }
    notifyListeners();
  }

  /// **Menambahkan ulasan baru**
  Future<void> addUlasan({
    required double rating,
    required String comment,
    File? imageFile,
    required BuildContext
        context, // Tambahkan context untuk mendapatkan user_id
  }) async {
    addUlasanState = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      // **Ambil user_id dari AuthProvider**
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.userNow?.idUser ?? '';

      final response = await Api.addUlasan(
        user_id: userId.toString(),
        rating: rating.toString(),
        comment: comment,
        imageFile: imageFile,
      );

      if (response.status == 200) {
        addUlasanState =
            DataStateModel(status: StateStatus.succes, data: response);

        await getUlasan(); // **Panggil getUlasan() setelah sukses**
      } else {
        addUlasanState = DataStateModel(
          status: StateStatus.error,
          errMessage: response.message ?? 'Gagal mengirim ulasan',
        );
      }
    } catch (ex) {
      addUlasanState = DataStateModel(
        status: StateStatus.error,
        errMessage: 'Terjadi kesalahan saat mengirim ulasan',
      );
    }
    notifyListeners();
  }
}
