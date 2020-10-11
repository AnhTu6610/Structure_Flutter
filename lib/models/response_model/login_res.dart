class LoginRes {
  bool error;
  Data data;

  LoginRes({this.error, this.data});

  LoginRes.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  UserRes user;
  String token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new UserRes.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class UserRes {
  List<String> store;
  int role;
  int status;
  String sId;
  String fullname;
  String gender;
  String username;
  String email;
  String phone;
  String modifyAt;
  String createAt;
  String mqttAccount;
  String mqttPass;

  UserRes(
      {this.store,
      this.role,
      this.status,
      this.sId,
      this.fullname,
      this.gender,
      this.username,
      this.email,
      this.phone,
      this.modifyAt,
      this.createAt,
      this.mqttAccount,
      this.mqttPass});

  UserRes.fromJson(Map<String, dynamic> json) {
    store = json['store'].cast<String>();
    role = json['role'];
    status = json['status'];
    sId = json['_id'];
    fullname = json['fullname'];
    gender = json['gender'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    modifyAt = json['modifyAt'];
    createAt = json['createAt'];
    mqttAccount = json['mqttAccount'];
    mqttPass = json['mqttPass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store'] = this.store;
    data['role'] = this.role;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['fullname'] = this.fullname;
    data['gender'] = this.gender;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['modifyAt'] = this.modifyAt;
    data['createAt'] = this.createAt;
    data['mqttAccount'] = this.mqttAccount;
    data['mqttPass'] = this.mqttPass;
    return data;
  }
}
