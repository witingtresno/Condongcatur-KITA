import 'package:flutter/material.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/repository/api.dart';
import 'package:desa_gempol/model/ajukan_layanan/get_response.dart';

class ResponeAjukan with ChangeNotifier {
  // State untuk menyimpan status dan data permohonan
  DataStateModel<GetResponse>? statePermohonan = DataStateModel(status: StateStatus.idle);

  // Fungsi untuk memuat data permohonan dari API
  Future<void> fetchPermohonan() async {
    statePermohonan = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      // Panggil API untuk mendapatkan data
      final response = await Api.getSubmissions();

      // Set state dengan data yang berhasil diambil
      statePermohonan = DataStateModel(
        status: StateStatus.succes,
        data: response, // Data permohonan
      );
    } catch (e) {
      // Set state menjadi error jika terjadi kesalahan
      statePermohonan = DataStateModel(
        status: StateStatus.error,
        errMessage: "Kesalahan memuat data: $e",
      );
    } finally {
      notifyListeners();
    }
  }
}






// import 'package:desa_gempol/model/ajukan_layanan/get_response.dart';
// import 'package:flutter/material.dart';
// import 'package:desa_gempol/repository/api.dart';
//
// class ResponeAjukan with ChangeNotifier {
//   bool _isLoading = false;
//   List<Data> _permohonanList = [];
//
//   bool get isLoading => _isLoading;
//   List<Data> get permohonanList => _permohonanList;
//
//   Future<void> fetchPermohonan() async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       // Mengambil data dari API
//       final response = await Api.getSubmissions();
//       // karna get respone sudah di api makan tidak perlu get lagi disini
//       final parsedResponse = response;
//       _permohonanList = parsedResponse.data ?? [];
//     } catch (e) {
//       print("Error fetching data: $e");
//       throw Exception("Kesalahan memuat data: $e");
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }

