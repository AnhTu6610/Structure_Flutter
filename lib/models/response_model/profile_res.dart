class ProfileRes {
  int code;
  DataProfileRes data;
  String mess;

  ProfileRes({this.code, this.data, this.mess});

  ProfileRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new DataProfileRes.fromJson(json['data']) : null;
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

class DataProfileRes {
  String sId;
  String phone;
  String email;
  String fullname;
  String createdAt;
  String updatedAt;
  String avatar;
  bool gender;

  DataProfileRes({this.sId, this.phone, this.email, this.fullname, this.createdAt, this.updatedAt, this.avatar, this.gender});

  DataProfileRes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phone = json['phone_number'];
    email = json['email'];
    fullname = json['fullname'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    avatar = json['avatar'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['phone_number'] = this.phone;
    data['email'] = this.email;
    data['fullname'] = this.fullname;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['avatar'] = this.avatar;
    data['gender'] = this.gender;
    return data;
  }
}
