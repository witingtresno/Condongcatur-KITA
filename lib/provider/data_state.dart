import 'package:flutter/material.dart';

class DataStateModel<T> {
  StateStatus status;
  T? data;
  String? errMessage;

  DataStateModel({required this.status, this.data, this.errMessage});
}

enum StateStatus { idle, loading, succes, error }

Widget dataStateHandler<T>({
  required DataStateModel status,
  required Function(T?) onSucces,
  required Function(String?) onFailed,
}) {
  if (status.status == StateStatus.loading) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  } else if (status.status == StateStatus.succes) {
    if (status.data is List) {
      List data = status.data as List;
      if (data.isEmpty) {
        return onFailed("Data Kosong");
      }
    }
    return onSucces(status.data);
  } else if (status.status == StateStatus.error) {
    return onFailed(status.errMessage!);
  }
  return const SizedBox();
}
