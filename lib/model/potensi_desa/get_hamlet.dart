class GetHamlet {
  GetHamlet({
      int? status, 
      String? message, 
      List<Data>? data, 
      String? responseAt,}){
    _status = status;
    _message = message;
    _data = data;
    _responseAt = responseAt;
}

  GetHamlet.fromJson(dynamic json) {
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

  Data.fromJson(dynamic json) {
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