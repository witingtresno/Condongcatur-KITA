class GetResponse {
  GetResponse({
      int? status, 
      String? message, 
      List<Data>? data, 
      String? responseAt,}){
    _status = status;
    _message = message;
    _data = data;
    _responseAt = responseAt;
}

  GetResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _responseAt = json['response_at'];
  }
  int? _status;
  String? _message;
  List<Data>? _data;
  String? _responseAt;

  int? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;
  String? get responseAt => _responseAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['response_at'] = _responseAt;
    return map;
  }

}

class Data {
  Data({
      int? id, 
      String? createdAt, 
      String? updatedAt, 
      int? nikId, 
      String? title, 
      String? date, 
      int? hamletId, 
      String? status, 
      String? requisite, 
      User? user, 
      Hamlet? hamlet,}){
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _nikId = nikId;
    _title = title;
    _date = date;
    _hamletId = hamletId;
    _status = status;
    _requisite = requisite;
    _user = user;
    _hamlet = hamlet;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _nikId = json['nik_id'];
    _title = json['title'];
    _date = json['date'];
    _hamletId = json['hamlet_id'];
    _status = json['status'];
    _requisite = json['requisite'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _hamlet = json['hamlet'] != null ? Hamlet.fromJson(json['hamlet']) : null;
  }
  int? _id;
  String? _createdAt;
  String? _updatedAt;
  int? _nikId;
  String? _title;
  String? _date;
  int? _hamletId;
  String? _status;
  String? _requisite;
  User? _user;
  Hamlet? _hamlet;

  int? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get nikId => _nikId;
  String? get title => _title;
  String? get date => _date;
  int? get hamletId => _hamletId;
  String? get status => _status;
  String? get requisite => _requisite;
  User? get user => _user;
  Hamlet? get hamlet => _hamlet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['nik_id'] = _nikId;
    map['title'] = _title;
    map['date'] = _date;
    map['hamlet_id'] = _hamletId;
    map['status'] = _status;
    map['requisite'] = _requisite;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_hamlet != null) {
      map['hamlet'] = _hamlet?.toJson();
    }
    return map;
  }

}

class Hamlet {
  Hamlet({
      int? id, 
      String? name, 
      String? image, 
      String? title, 
      String? leader, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _image = image;
    _title = title;
    _leader = leader;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Hamlet.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _title = json['title'];
    _leader = json['leader'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _image;
  String? _title;
  String? _leader;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get title => _title;
  String? get leader => _leader;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['title'] = _title;
    map['leader'] = _leader;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class User {
  User({
      int? id, 
      String? name, 
      int? nik, 
      int? isAdmin, 
      String? emailVerifiedAt, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _nik = nik;
    _isAdmin = isAdmin;
    _emailVerifiedAt = emailVerifiedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _nik = json['nik'];
    _isAdmin = json['is_admin'];
    _emailVerifiedAt = json['email_verified_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  int? _nik;
  int? _isAdmin;
  String? _emailVerifiedAt;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  int? get nik => _nik;
  int? get isAdmin => _isAdmin;
  String? get emailVerifiedAt => _emailVerifiedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['nik'] = _nik;
    map['is_admin'] = _isAdmin;
    map['email_verified_at'] = _emailVerifiedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}