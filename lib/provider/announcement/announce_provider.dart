import 'package:desa_gempol/model/announcement/announcement.dart';
import 'package:desa_gempol/model/announcement/get_detail_announcement.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/repository/api.dart';
import 'package:flutter/material.dart';

class AnnounceProvider extends ChangeNotifier {
  DataStateModel<Announcement>? stateAnnounce =
      DataStateModel(status: StateStatus.idle);
  DataStateModel<GetDetailAnnouncement>? stateDetailAnnounce =
      DataStateModel(status: StateStatus.idle);

  Future getAnnounce() async {
    stateAnnounce = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      final res = await Api.getAnnouncement();
      stateAnnounce = DataStateModel(status: StateStatus.succes, data: res);
      notifyListeners();
    } catch (ex) {
      stateAnnounce =
          DataStateModel(status: StateStatus.error, errMessage: 'Error');
      notifyListeners();
    }
  }

  Future getDetailAnnounce({required String idAnnounce}) async {
    stateDetailAnnounce = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      final res = await Api.getDetailAnnouncement(idAnnouncement: idAnnounce);
      stateDetailAnnounce =
          DataStateModel(status: StateStatus.succes, data: res);
      notifyListeners();
    } catch (ex) {
      stateDetailAnnounce =
          DataStateModel(status: StateStatus.error, errMessage: 'Error');
      notifyListeners();
    }
  }
}
