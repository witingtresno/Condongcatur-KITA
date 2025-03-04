import 'dart:convert';
import 'dart:io';
import 'package:desa_gempol/model/ajukan_layanan/ajukan_layanan.dart';
import 'package:desa_gempol/model/ajukan_layanan/get_response.dart';
import 'package:desa_gempol/model/announcement/announcement.dart';
import 'package:desa_gempol/model/announcement/get_detail_announcement.dart';
import 'package:desa_gempol/model/auth/login.dart';
import 'package:desa_gempol/model/auth/register.dart';
import 'package:desa_gempol/model/forum/destroy_forum.dart';
import 'package:desa_gempol/model/forum/get_all_forum.dart';
import 'package:desa_gempol/model/forum/store_forum.dart';
import 'package:desa_gempol/model/forum/update_forum.dart';
import 'package:desa_gempol/model/gallery/get_detail_gallery.dart';
import 'package:desa_gempol/model/gallery/get_gallery.dart';
import 'package:desa_gempol/model/news/get_detail_news.dart';
import 'package:desa_gempol/model/news/get_news.dart';
import 'package:desa_gempol/model/potensi_desa/get_detail_hamlet.dart';
import 'package:desa_gempol/model/potensi_desa/get_hamlet.dart';
import 'package:desa_gempol/model/ulasan/get_all_ulasan.dart';
import 'package:desa_gempol/model/ulasan/post_ulasan.dart';
import 'package:http/http.dart' as http;

String BASE_URL = "https://apidesa.workest.web.id/api";
String BASE_IMAGE_URL = "https://apidesa.workest.web.id/";

class Api {
  // Login
  static Future<Login> setLogin(
      {required String nik, required String password}) async {
    Uri url = Uri.parse('$BASE_URL/login');

    Map<String, String> dataUser = {
      "nik": nik,
      "password": password,
    };

    // throw jsonEncode(dataUser);
    final response = await http.post(url, body: dataUser);
    // throw jsonEncode(response.body);
    if (response.statusCode >= 400) {
      Map<String, dynamic> dataError = jsonDecode(response.body);
      // throw ini dari isi postman klo salah pas login
      throw dataError['error'];
    }
    return Login.fromJson(jsonDecode(response.body));
  }

//   Register

  static Future<Register> setRegister({
    required String name,
    required String nik,
    required String password,
  }) async {
    Uri url = Uri.parse('$BASE_URL/register');
    Map<String, String> dataUser = {
      "name": name,
      "nik": nik,
      "password": password,
    };

    try {
      final response = await http.post(url, body: dataUser);

      if (response.statusCode >= 400) {
        final Map<String, dynamic> dataError = jsonDecode(response.body);
        throw dataError['message'];
      }

      return Register.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw 'Registration failed: $e';
    }
  }

//   get NEWS

  static Future<GetNews> getNews() async {
    Uri url = Uri.parse('$BASE_URL/news/all');

    final response = await http.get(url);
    // print('Status Code: ${response.statusCode}');
    // print('Body: ${response.body}');

    if (response.statusCode >= 400) {
      final Map<String, dynamic> dataError = jsonDecode(response.body);
      throw dataError['message'];
    }

    return GetNews.fromJson(jsonDecode(response.body));
  }

  // GET DETAIL NEWS

  static Future<GetDetailNews> getDetailNews({required String idNews}) async {
    Uri url = Uri.parse('$BASE_URL/news/detail/$idNews');

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      Map<String, dynamic> dataError = jsonDecode(response.body);
      throw dataError['message'];
    }
    return GetDetailNews.fromJson(jsonDecode(response.body));
  }

  // Get Gallery

  static Future<GetGallery> getGallery() async {
    Uri url = Uri.parse('$BASE_URL/gallery/all');

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      Map<String, dynamic> dataError = jsonDecode(response.body);
      throw dataError['message'];
    }
    return GetGallery.fromJson(jsonDecode(response.body));
  }

  // Get DETAIL Gallery
  static Future<GetDetailGallery> getDetailGallery(
      {required String idGallery}) async {
    Uri url = Uri.parse('$BASE_URL/gallery/detail/$idGallery');

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      Map<String, dynamic> dataError = jsonDecode(response.body);
      throw dataError['message'];
    }
    jsonDecode(response.body);


    return GetDetailGallery.fromJson(jsonDecode(response.body));
  }

//   get announcement

  static Future<Announcement> getAnnouncement() async {
    Uri url = Uri.parse('$BASE_URL/announcement/all');

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      Map<String, dynamic> dataError = jsonDecode(response.body);
      throw dataError['message'];
    }
    return Announcement.fromJson(jsonDecode(response.body));
  }

  static Future<GetDetailAnnouncement> getDetailAnnouncement(
      {required String idAnnouncement}) async {
    Uri url = Uri.parse('$BASE_URL/announcement/detail/$idAnnouncement');

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      Map<String, dynamic> dataError = jsonDecode(response.body);
      throw dataError['message'];
    }
    return GetDetailAnnouncement.fromJson(jsonDecode(response.body));
  }

//   get Hamlet

  static Future<GetHamlet> getHamlet() async {
    Uri url = Uri.parse('$BASE_URL/hamlet/all');

    final respone = await http.get(url);

    if (respone.statusCode >= 400) {
      Map<String, dynamic> dataError = jsonDecode(respone.body);
      throw dataError['message'];
    }
    return GetHamlet.fromJson(jsonDecode(respone.body));
  }

  static Future<GetDetailHamlet> getDetailHamlet(
      {required String idHamlet}) async {
    Uri url = Uri.parse('$BASE_URL/hamlet/detail/$idHamlet');

    final respone = await http.get(url);

    if (respone.statusCode >= 400) {
      Map<String, dynamic> dataError = jsonDecode(respone.body);
      throw dataError['message'];
    }
    return GetDetailHamlet.fromJson(jsonDecode(respone.body));
  }

// Add Submission
  static Future<AjukanLayanan> addSubmission({
    required String nikId,
    required String title,
    required String hamletName, // Menggunakan hamletName alih-alih hamletId
    required String requisite,
  }) async {
    final String url = "$BASE_URL/submission/store";

    try {
      Map<String, String> body = {
        "nik_id": nikId,
        "title": title,
        "hamlet_id": hamletName, // Ganti ke hamlet_name
        "requisite": requisite,
      };



      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(body),
      );


      if (response.statusCode == 200) {
        return AjukanLayanan.fromJson(jsonDecode(response.body));
      } else {
        final responseBody = jsonDecode(response.body);
        if (responseBody is Map && responseBody.containsKey('message')) {
          throw Exception("Error dari server: ${responseBody['message']}");
        } else {
          throw Exception("Error tidak diketahui. Respons: ${response.body}");
        }
      }
    } catch (e) {

      throw Exception("Gagal menambahkan pengajuan. Kesalahan: $e");
    }
  }

  static Future<GetResponse> getSubmissions() async {
    final response = await http.get(
      Uri.parse(
          "$BASE_URL/submission/all"), // removed /api/ since BASE_URL already includes it
    );


    if (response.statusCode == 200) {
      return GetResponse.fromJson(jsonDecode(response.body));
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody is Map && responseBody.containsKey('message')) {
        throw Exception("Error dari server: ${responseBody['message']}");
      } else {
        throw Exception("Error tidak diketahui. Respons: ${response.body}");
      }
    }
  }

//   Get Forum

  static Future<GetAllForum> getForum() async {
    final response = await http.get(
      Uri.parse(
          "$BASE_URL/forum/all"),
    );



    if (response.statusCode == 200) {
      return GetAllForum.fromJson(jsonDecode(response.body));
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody is Map && responseBody.containsKey('message')) {
        throw Exception("Error dari server: ${responseBody['message']}");
      } else {
        throw Exception("Error tidak diketahui. Respons: ${response.body}");
      }
    }
  }

  // Get Detail Forum



  // add Forum

  static Future<StoreForum> addForum(
      {required String user_id,
      File? imageFile,
      required String description}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$BASE_URL/forum/store'));

    request.fields['user_id'] = user_id;
    request.fields['description'] = description;

    if (imageFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));
    }

    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    if (response.statusCode >= 400) {
      Map<String, dynamic> dataError = jsonDecode(responseData);
      throw dataError['message'];
    }

    return StoreForum.fromJson(jsonDecode(responseData));
  }

  static Future<UpdateForum> updateForum({
    required String idForum,
    required String description,
    File? imageFile,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$BASE_URL/forum/update/$idForum'),
    );

    request.fields['description'] = description;

    if (imageFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));
    }

    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    if (response.statusCode >= 400) {
      Map<String, dynamic> dataError = jsonDecode(responseData);
      throw dataError['message'];
    }

    return UpdateForum.fromJson(jsonDecode(responseData));
  }

  static Future<DestroyForum> deleteForum({required String idForum}) async {
    Uri url = Uri.parse('$BASE_URL/forum/destroy/$idForum');

    final response = await http.delete(url);



    if (response.statusCode >= 400) {
      Map<String, dynamic> dataError = jsonDecode(response.body);
      throw dataError['message'];
    }
    return DestroyForum.fromJson(jsonDecode(response.body));
  }

  static Future<GetAllUlasan> getAllUlasan() async {
    final respone = await http.get(
      Uri.parse('$BASE_URL/reviews/all'),
    );

    if (respone.statusCode >= 400) {
      final Map<String, dynamic> dataError = jsonDecode(respone.body);
      throw dataError['message'];
    }
    return GetAllUlasan.fromJson(jsonDecode(respone.body));
  }

  static Future<PostUlasan> addUlasan(
      {required String user_id,
      File? imageFile,
      required String comment,
      required String rating}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$BASE_URL/reviews/store'));

    request.fields['user_id'] = user_id;
    request.fields['comment'] = comment;
    request.fields['rating'] = rating;

    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    }
    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    if (response.statusCode >= 400) {
      Map<String, dynamic> dataError = jsonDecode(responseData);
      throw dataError['message'];
    }
    return PostUlasan.fromJson(jsonDecode(responseData));
  }
}
