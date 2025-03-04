import 'dart:io';
import 'package:desa_gempol/model/forum/update_forum.dart' as update_Forum;
import 'package:desa_gempol/provider/data_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:desa_gempol/repository/data_user.dart';
import 'package:desa_gempol/repository/api.dart';
import 'package:desa_gempol/model/forum/get_all_forum.dart' as getAllForum;
import 'package:desa_gempol/model/forum/store_forum.dart' as storeForum;
import 'package:desa_gempol/model/forum/destroy_forum.dart' as destroyForum;

class ForumProvider extends ChangeNotifier {
  // State models for CRUD operations
  DataStateModel<getAllForum.GetAllForum>? fetchForumsState =
      DataStateModel(status: StateStatus.idle);
  DataStateModel<storeForum.StoreForum> addForumState =
      DataStateModel(status: StateStatus.idle);
  DataStateModel<update_Forum.UpdateForum> updateForumState =
      DataStateModel(status: StateStatus.idle);
  DataStateModel<destroyForum.DestroyForum> deleteForumState =
      DataStateModel(status: StateStatus.idle);

  // Selected image for forum
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  void setSelectedImage(File? imagePath) {
    _selectedImage = imagePath;
    notifyListeners();
  }

  // Fetch all forums
  Future<void> fetchForums() async {
    fetchForumsState = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      final response = await Api.getForum();
      fetchForumsState =
          DataStateModel(status: StateStatus.succes, data: response);
    } catch (err) {
      fetchForumsState = DataStateModel(
        status: StateStatus.error,
        errMessage: "error $err",
      );
    } finally {
      notifyListeners();
    }
  }

  // Add forum
  Future addForum({
    required String description,
    File? imageFile,
  }) async {
    addForumState = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      DataUser user = DataUser.fromPref(sharedPref);

      await Api.addForum(
        user_id: user.name!,
        description: description,
        imageFile: imageFile,
      );

      await fetchForums();

      addForumState = DataStateModel(status: StateStatus.succes);
      notifyListeners();
    } catch (err) {
      addForumState = DataStateModel(
        status: StateStatus.error,
        errMessage: "Error: $err",
      );
      notifyListeners();
    }
  }

  // Update forum
  Future<void> updateForum({
    required String id,
    required String description,
    File? imageFile, // Tambahkan parameter untuk gambar
  }) async {
    updateForumState = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      await Api.updateForum(
        idForum: id,
        description: description,
        imageFile: imageFile, // Kirim gambar ke API jika ada
      );

      await fetchForums(); // Refresh data forum setelah update

      updateForumState = DataStateModel(status: StateStatus.succes);
    } catch (err) {
      updateForumState = DataStateModel(
        status: StateStatus.error,
        errMessage: "Gagal memperbarui forum. Error: $err",
      );
    } finally {
      notifyListeners();
    }
  }

  // Delete forum
  Future<void> deleteForum(String id) async {
    deleteForumState = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      final response = await Api.deleteForum(idForum: id);
      deleteForumState =
          DataStateModel(status: StateStatus.succes, data: response);

      // Perbarui daftar forum setelah penghapusan
      await fetchForums();
    } catch (err) {
      deleteForumState = DataStateModel(
        status: StateStatus.error,
        errMessage: "Gagal menghapus forum. Error: $err",
      );
    } finally {
      notifyListeners();
    }
  }
}
