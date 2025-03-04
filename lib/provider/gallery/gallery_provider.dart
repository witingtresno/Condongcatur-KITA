import 'package:desa_gempol/model/gallery/get_detail_gallery.dart';
import 'package:desa_gempol/model/gallery/get_gallery.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/repository/api.dart';
import 'package:flutter/material.dart';

class GalleryProvider extends ChangeNotifier {
  DataStateModel<GetGallery>? stateGallery =
      DataStateModel(status: StateStatus.idle);
  DataStateModel<GetDetailGallery>? stateDetailGallery =
      DataStateModel(status: StateStatus.idle);

  Future getGallery() async {
    stateGallery = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      final res = await Api.getGallery();
      stateGallery = DataStateModel(status: StateStatus.succes, data: res);
      notifyListeners();
    } catch (ex) {
      stateGallery =
          DataStateModel(status: StateStatus.error, errMessage: 'Error');
      notifyListeners();
    }
  }

  Future getDetailGallery({required String idGallery}) async {
    stateDetailGallery = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      final res = await Api.getDetailGallery(idGallery: idGallery);
      stateDetailGallery =
          DataStateModel(status: StateStatus.succes, data: res);
      notifyListeners();
    } catch (ex) {
      stateDetailGallery =
          DataStateModel(status: StateStatus.error, errMessage: 'Error');
      notifyListeners();
    }
  }
}
