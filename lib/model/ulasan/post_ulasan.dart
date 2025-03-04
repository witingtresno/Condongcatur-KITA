class PostUlasan {
  PostUlasan({
      int? status, 
      String? message, 
      Data? data, 
      String? responseAt,}){
    _status = status;
    _message = message;
    _data = data;
    _responseAt = responseAt;
}

  PostUlasan.fromJson(dynamic json) {
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
      String? userId, 
      String? rating, 
      String? comment, 
      String? image, 
      String? updatedAt, 
      String? createdAt, 
      int? id,}){
    _userId = userId;
    _rating = rating;
    _comment = comment;
    _image = image;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _rating = json['rating'];
    _comment = json['comment'];
    _image = json['image'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _userId;
  String? _rating;
  String? _comment;
  String? _image;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  String? get userId => _userId;
  String? get rating => _rating;
  String? get comment => _comment;
  String? get image => _image;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['rating'] = _rating;
    map['comment'] = _comment;
    map['image'] = _image;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}