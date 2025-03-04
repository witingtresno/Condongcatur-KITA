class DestroyForum {
  DestroyForum({
      int? status, 
      String? message, 
      dynamic data, 
      String? responseAt,}){
    _status = status;
    _message = message;
    _data = data;
    _responseAt = responseAt;
}

  DestroyForum.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
    _responseAt = json['response_at'];
  }
  int? _status;
  String? _message;
  dynamic _data;
  String? _responseAt;

  int? get status => _status;
  String? get message => _message;
  dynamic get data => _data;
  String? get responseAt => _responseAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    map['response_at'] = _responseAt;
    return map;
  }

}