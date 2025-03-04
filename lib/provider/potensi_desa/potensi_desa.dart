import 'package:desa_gempol/model/potensi_desa/get_detail_hamlet.dart';
import 'package:desa_gempol/model/potensi_desa/get_hamlet.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/repository/api.dart';
import 'package:flutter/material.dart';

class PotensiDesa extends ChangeNotifier {
  DataStateModel<GetHamlet>? statePotensi =
      DataStateModel(status: StateStatus.idle);
  DataStateModel<GetDetailHamlet>? stateDetailPotensi =
      DataStateModel(status: StateStatus.idle);

  Future getPotensi() async {
    statePotensi = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      final res = await Api.getHamlet();
      statePotensi = DataStateModel(status: StateStatus.succes, data: res);
      notifyListeners();
    } catch (ex) {
      statePotensi =
          DataStateModel(status: StateStatus.error, errMessage: 'Error');
      notifyListeners();
    }
  }

  Future getDetailHamlet({required String idHamlet}) async {
    stateDetailPotensi = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      final res = await Api.getDetailHamlet(idHamlet: idHamlet);
      stateDetailPotensi =
          DataStateModel(status: StateStatus.succes, data: res);
      notifyListeners();
    } catch (ex) {
      stateDetailPotensi =
          DataStateModel(status: StateStatus.error, errMessage: 'Error');
      notifyListeners();
    }
  }
}
