class GetDetailGallery {
  GetDetailGallery({
      int? status, 
      String? message, 
      Data? data, 
      String? responseAt,}){
    _status = status;
    _message = message;
    _data = data;
    _responseAt = responseAt;
}

  GetDetailGallery.fromJson(dynamic json) {
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
      String? createdAt, 
      String? updatedAt, 
      List<Images>? images,}){
    _id = id;
    _image = image;
    _title = title;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _images = images;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _title = json['title'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
  }
  int? _id;
  String? _image;
  String? _title;
  String? _createdAt;
  String? _updatedAt;
  List<Images>? _images;

  int? get id => _id;
  String? get image => _image;
  String? get title => _title;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Images>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['title'] = _title;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Images {
  Images({
      int? id, 
      int? galleryId, 
      String? image, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _galleryId = galleryId;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Images.fromJson(dynamic json) {
    _id = json['id'];
    _galleryId = json['gallery_id'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _galleryId;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get galleryId => _galleryId;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['gallery_id'] = _galleryId;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}