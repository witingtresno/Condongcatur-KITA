class AjukanLayanan {
  AjukanLayanan({
      int? status, 
      String? message, 
      Data? data, 
      String? responseAt,}){
    _status = status;
    _message = message;
    _data = data;
    _responseAt = responseAt;
}

  AjukanLayanan.fromJson(dynamic json) {
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
      int? nikId, 
      String? title, 
      String? date, 
      int? hamletId, 
      String? status, 
      String? requisite, 
      String? updatedAt, 
      String? createdAt, 
      int? id,}){
    _nikId = nikId;
    _title = title;
    _date = date;
    _hamletId = hamletId;
    _status = status;
    _requisite = requisite;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _nikId = json['nik_id'];
    _title = json['title'];
    _date = json['date'];
    _hamletId = json['hamlet_id'];
    _status = json['status'];
    _requisite = json['requisite'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  int? _nikId;
  String? _title;
  String? _date;
  int? _hamletId;
  String? _status;
  String? _requisite;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  int? get nikId => _nikId;
  String? get title => _title;
  String? get date => _date;
  int? get hamletId => _hamletId;
  String? get status => _status;
  String? get requisite => _requisite;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nik_id'] = _nikId;
    map['title'] = _title;
    map['date'] = _date;
    map['hamlet_id'] = _hamletId;
    map['status'] = _status;
    map['requisite'] = _requisite;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}