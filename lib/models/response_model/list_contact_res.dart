class ListContactRes {
  int code;
  List<ContactRes> data;
  String mess;

  ListContactRes({this.code, this.data, this.mess});

  ListContactRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<ContactRes>();
      json['data'].forEach((v) {
        data.add(new ContactRes.fromJson(v));
      });
    }
    mess = json['mess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['mess'] = this.mess;
    return data;
  }
}

class ContactRes {
  String sId;
  String name;
  String email;
  String phoneNumber;

  ContactRes({this.sId, this.name, this.email, this.phoneNumber});

  ContactRes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}
