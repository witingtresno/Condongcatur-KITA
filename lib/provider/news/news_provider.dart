import 'package:desa_gempol/model/news/get_detail_news.dart';
import 'package:desa_gempol/model/news/get_news.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/repository/api.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  DataStateModel<GetNews>? stateNews = DataStateModel(status: StateStatus.idle);
  DataStateModel<GetDetailNews>? stateDetailNews =
      DataStateModel(status: StateStatus.idle);

  Future getNews() async {
    stateNews = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      final res = await Api.getNews();
      stateNews = DataStateModel(status: StateStatus.succes, data: res);
      notifyListeners();
    } catch (ex) {
      stateNews =
          DataStateModel(status: StateStatus.error, errMessage: 'Error');
      notifyListeners();
    }
  }

  Future getDetailNews({required String idNews}) async {
    stateDetailNews = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      final res = await Api.getDetailNews(idNews: idNews);
      stateDetailNews = DataStateModel(status: StateStatus.succes, data: res);
      notifyListeners();
      // print(res);
    } catch (ex) {
      stateDetailNews =
          DataStateModel(status: StateStatus.error, errMessage: 'Get News $ex');
      notifyListeners();
    }
  }
}
