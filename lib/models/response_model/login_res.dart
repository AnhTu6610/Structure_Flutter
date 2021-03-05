class LoginRes {
  int code;
  DataLoginRes data;
  String mess;

  LoginRes({this.code, this.data, this.mess});

  LoginRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new DataLoginRes.fromJson(json['data']) : null;
    mess = json['mess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['mess'] = this.mess;
    return data;
  }
}

class DataLoginRes {
  String token;
  bool isVerified;

  DataLoginRes({this.token, this.isVerified});

  DataLoginRes.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['is_verified'] = this.isVerified;
    return data;
  }
}
