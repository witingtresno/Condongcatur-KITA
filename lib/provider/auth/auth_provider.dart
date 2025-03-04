import 'package:desa_gempol/model/auth/login.dart';
import 'package:desa_gempol/model/auth/register.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/repository/api.dart';
import 'package:desa_gempol/repository/data_user.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  DataStateModel<Login> stateLogin = DataStateModel(status: StateStatus.idle);
  DataStateModel<Register> stateRegister =
  DataStateModel(status: StateStatus.idle);

  SharedPreferences? _sharedPreferences;

  String next = "";

  DataUser? userNow;

  // Getter untuk memeriksa apakah user sudah login
  bool get isLoggedIn => userNow != null;

  Future<void> setLogin({required String nik, required String password}) async {

    stateLogin = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {
      final res = await Api.setLogin(nik: nik, password: password);



      // Simpan data user ke SharedPreferences
      await _storePref(
        idUser: res.data!.id!.toInt(),
        nik: res.data!.nik!.toString(),
        name: res.data!.name!,
        password: password,
        token: res.data!.token!,
      );

      // Ambil kembali data user untuk memastikan sinkronisasi
      await _getPref();

      _jwtDetails(res.data!.token!);
      stateLogin = DataStateModel(status: StateStatus.succes, data: res);
    } catch (ex) {
      stateLogin = DataStateModel(
        status: StateStatus.error,
        errMessage: 'Username Belum Terdaftar',
      );

    } finally {
      notifyListeners();
    }
  }

  _jwtDetails(String token) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      bool hasExpired = JwtDecoder.isExpired(token);

      if (hasExpired) {

        logout(); // Logout otomatis jika token kedaluwarsa
      }

      DateTime expirationDate = JwtDecoder.getExpirationDate(token);
      Duration tokenTime = JwtDecoder.getTokenTime(token);


    } catch (e) {
      rethrow;
    }
  }

  Future<void> checkTokenValidity(BuildContext context) async {
    try {
      if (userNow?.token == null || JwtDecoder.isExpired(userNow!.token!)) {

        await logout(); // Logout jika token kedaluwarsa
        Navigator.pushNamedAndRemoveUntil(
          context,
          CustomRoute.loginScreen,
              (route) => false,
        ); // Arahkan ke halaman login
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setRegister({
    required String name,
    required String nik,
    required String password,
  }) async {

    stateRegister = DataStateModel(status: StateStatus.loading);
    notifyListeners();

    try {

      final res = await Api.setRegister(name: name, nik: nik, password: password);

      if (res.data == null) {
        throw 'User data is null from API response';
      }


      // Simpan data user ke SharedPreferences
      await _storePref(
        idUser: res.data!.id!.toInt(), // ID user dari response
        nik: res.data!.nik!.toString(), // NIK dari response
        name: res.data!.name!, // Nama lengkap dari response
        password: password,
        token: "",
      );

      // Ambil kembali data user untuk memastikan sinkronisasi
      await _getPref();

      stateRegister = DataStateModel(status: StateStatus.succes, data: res);

    } catch (ex) {
      stateRegister = DataStateModel(
        status: StateStatus.error,
        errMessage: 'Register Error: $ex',
      );

    } finally {
      notifyListeners();
    }
  }

  Future<void> loginOk(BuildContext context, String routeNext) async {
    next = routeNext;
    notifyListeners();

    try {
      bool resCek = await cekPref();
      if (!resCek || JwtDecoder.isExpired(userNow!.token!)) {

        await Navigator.pushNamed(context, CustomRoute.loginScreen);

        // Setelah kembali dari login, cek ulang status login
        if (!isLoggedIn) {
          throw Exception("Anda harus login untuk melanjutkan.");
        }
      }
    } catch (e) {
     rethrow;
    }
  }

  Future<void> logout() async {
    await _deletePref();
    stateRegister = DataStateModel(status: StateStatus.idle);
    stateLogin = DataStateModel(status: StateStatus.idle);
    userNow = null;
    notifyListeners();
  }

  Future<void> _storePref({
    required int idUser,
    required String nik,
    required String name,
    required String password,
    required String token,
  }) async {
    if (idUser <= 0 || nik.isEmpty || name.isEmpty || password.isEmpty) {
      throw Exception("Data user tidak valid untuk disimpan.");
    }

    await _initSharedPreferences();
    await DataUser.setPref(
      _sharedPreferences!,
      idUser,
      nik,
      name,
      password,
      token,
    );
  }

  Future<void> _getPref() async {
    final exists = await cekPref();

    if (!exists) {
      throw Exception('No data found in local storage');
    }

    await _initSharedPreferences();
    userNow = DataUser.fromPref(_sharedPreferences!);
  }

  Future<void> _deletePref() async {
    await _initSharedPreferences();
    _sharedPreferences?.clear();
  }

  Future<bool> cekPref() async {
    await _initSharedPreferences();

    bool hasIdUser = _sharedPreferences?.containsKey(DataUser.IDUSER) ?? false;
    bool hasNik = _sharedPreferences?.containsKey(DataUser.NIK) ?? false;
    bool hasPassword = _sharedPreferences?.containsKey(DataUser.PASSWORD) ?? false;

    if (hasIdUser && hasNik && hasPassword) {
      userNow = DataUser.fromPref(_sharedPreferences!);
      return true;
    }

    return false;
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }
}
