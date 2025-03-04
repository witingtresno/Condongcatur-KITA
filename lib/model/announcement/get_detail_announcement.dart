class GetDetailAnnouncement {
  GetDetailAnnouncement({
      int? status, 
      String? message, 
      Data? data, 
      String? responseAt,}){
    _status = status;
    _message = message;
    _data = data;
    _responseAt = responseAt;
}

  GetDetailAnnouncement.fromJson(dynamic json) {
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
      String? image, 
      String? title, 
      String? description, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _image = image;
    _title = title;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _title = json['title'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _image;
  String? _title;
  String? _description;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get image => _image;
  String? get title => _title;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['title'] = _title;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}