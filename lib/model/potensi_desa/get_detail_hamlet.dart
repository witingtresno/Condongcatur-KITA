class GetDetailHamlet {
  GetDetailHamlet({
      int? status, 
      String? message, 
      Data? data, 
      String? responseAt,}){
    _status = status;
    _message = message;
    _data = data;
    _responseAt = responseAt;
}

  GetDetailHamlet.fromJson(dynamic json) {
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
      String? image, 
      String? title, 
      String? leader, 
      String? createdAt, 
      String? updatedAt, 
      List<Details>? details,}){
    _id = id;
    _name = name;
    _image = image;
    _title = title;
    _leader = leader;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _details = details;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _title = json['title'];
    _leader = json['leader'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['details'] != null) {
      _details = [];
      json['details'].forEach((v) {
        _details?.add(Details.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  String? _image;
  String? _title;
  String? _leader;
  String? _createdAt;
  String? _updatedAt;
  List<Details>? _details;

  int? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get title => _title;
  String? get leader => _leader;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Details>? get details => _details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['title'] = _title;
    map['leader'] = _leader;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_details != null) {
      map['details'] = _details?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Details {
  Details({
      int? id, 
      int? hamletsId, 
      double? latitude, 
      double? longitude, 
      String? createdAt, 
      String? updatedAt, 
      List<Galleries>? galleries,}){
    _id = id;
    _hamletsId = hamletsId;
    _latitude = latitude;
    _longitude = longitude;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _galleries = galleries;
}

  Details.fromJson(dynamic json) {
    _id = json['id'];
    _hamletsId = json['hamlets_id'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['galleries'] != null) {
      _galleries = [];
      json['galleries'].forEach((v) {
        _galleries?.add(Galleries.fromJson(v));
      });
    }
  }
  int? _id;
  int? _hamletsId;
  double? _latitude;
  double? _longitude;
  String? _createdAt;
  String? _updatedAt;
  List<Galleries>? _galleries;

  int? get id => _id;
  int? get hamletsId => _hamletsId;
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Galleries>? get galleries => _galleries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['hamlets_id'] = _hamletsId;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_galleries != null) {
      map['galleries'] = _galleries?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Galleries {
  Galleries({
      int? id, 
      String? image, 
      int? hamletDetailId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _image = image;
    _hamletDetailId = hamletDetailId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Galleries.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _hamletDetailId = json['hamlet_detail_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _image;
  int? _hamletDetailId;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get image => _image;
  int? get hamletDetailId => _hamletDetailId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['hamlet_detail_id'] = _hamletDetailId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}