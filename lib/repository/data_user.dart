import 'package:shared_preferences/shared_preferences.dart';

class DataUser {
  // Konstanta untuk penyimpanan
  static const IDUSER = 'id_user';
  static const NIK = 'nik';
  static const NAME = 'name';
  static const PASSWORD = 'password';
  static const TOKEN = 'token';

  int? idUser;
  String? nik;
  String? name;
  String? password;
  String? token;

  // Konstruktor utama
  DataUser({this.idUser,this.nik, this.name, this.password, this.token});

  // Ambil data dari SharedPreferences
  DataUser.fromPref(SharedPreferences data) {
    idUser = data.getInt(IDUSER);
    nik = data.getString(NIK);
    name = data.getString(NAME);
    password = data.getString(PASSWORD);
    token = data.getString(TOKEN);

    // Tambahkan validasi
    if (idUser == null || nik == null || name == null) {
      throw 'Data user tidak lengkap';
    }
  }

  // Simpan data ke SharedPreferences
  static Future<void> setPref(
      SharedPreferences data, int idUser,String nik, String name, String password, String token) async {
    await data.setInt(IDUSER, idUser);
    await data.setString(NIK, nik);
    await data.setString(NAME, name);
    await data.setString(PASSWORD, password);
    await data.setString(TOKEN, token);
  }
}
