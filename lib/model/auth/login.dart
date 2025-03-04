class Login {
  Login({
      int? status, 
      String? message, 
      Data? data, 
      String? responseAt,}){
    _status = status;
    _message = message;
    _data = data;
    _responseAt = responseAt;
}

  Login.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _responseAt = json['response_at'];
  }
  int? _status;
  String? _message;
  Data? _data;
  String? _responseAt;

  int? get status => _status;
  String? get message => _message;
  Data? get data => _data;
  String? get responseAt => _responseAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['response_at'] = _responseAt;
    return map;
  }

}

class Data {
  Data({
      int? id, 
      String? name, 
      int? nik, 
      int? isAdmin, 
      dynamic emailVerifiedAt, 
      String? createdAt, 
      String? updatedAt, 
      String? token,}){
    _id = id;
    _name = name;
    _nik = nik;
    _isAdmin = isAdmin;
    _emailVerifiedAt = emailVerifiedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _token = token;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _nik = json['nik'];
    _isAdmin = json['is_admin'];
    _emailVerifiedAt = json['email_verified_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _token = json['token'];
  }
  int? _id;
  String? _name;
  int? _nik;
  int? _isAdmin;
  dynamic _emailVerifiedAt;
  String? _createdAt;
  String? _updatedAt;
  String? _token;

  int? get id => _id;
  String? get name => _name;
  int? get nik => _nik;
  int? get isAdmin => _isAdmin;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['nik'] = _nik;
    map['is_admin'] = _isAdmin;
    map['email_verified_at'] = _emailVerifiedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['token'] = _token;
    return map;
  }

}