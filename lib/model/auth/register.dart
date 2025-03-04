class Register {
  Register({
      num? status, 
      String? message, 
      Data? data, 
      String? responseAt,}){
    _status = status;
    _message = message;
    _data = data;
    _responseAt = responseAt;
}

  Register.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _responseAt = json['response_at'];
  }
  num? _status;
  String? _message;
  Data? _data;
  String? _responseAt;

  num? get status => _status;
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
      String? name, 
      String? nik, 
      bool? isAdmin, 
      String? updatedAt, 
      String? createdAt, 
      num? id,}){
    _name = name;
    _nik = nik;
    _isAdmin = isAdmin;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _nik = json['nik'];
    _isAdmin = json['is_admin'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _name;
  String? _nik;
  bool? _isAdmin;
  String? _updatedAt;
  String? _createdAt;
  num? _id;

  String? get name => _name;
  String? get nik => _nik;
  bool? get isAdmin => _isAdmin;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['nik'] = _nik;
    map['is_admin'] = _isAdmin;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}