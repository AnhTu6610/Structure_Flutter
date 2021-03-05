class ListVoucherRes {
  int code;
  DataListVoucherRes data;
  String mess;

  ListVoucherRes({this.code, this.data, this.mess});

  ListVoucherRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new DataListVoucherRes.fromJson(json['data']) : null;
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

class DataListVoucherRes {
  int limit;
  int page;
  List<VoucherRes> data;
  int totalResults;

  DataListVoucherRes({this.limit, this.page, this.data, this.totalResults});

  DataListVoucherRes.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    page = json['page'];
    if (json['data'] != null) {
      data = new List<VoucherRes>();
      json['data'].forEach((v) {
        data.add(new VoucherRes.fromJson(v));
      });
    }
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['page'] = this.page;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total_results'] = this.totalResults;
    return data;
  }
}

class VoucherRes {
  String sId;
  String type;
  int maxBill;
  int minBill;
  String content;
  String title;
  String code;
  String expiredAt;
  int number;
  String img;
  String createdAt;
  String updatedAt;

  VoucherRes(
      {this.sId,
      this.type,
      this.maxBill,
      this.minBill,
      this.content,
      this.title,
      this.code,
      this.expiredAt,
      this.number,
      this.img,
      this.createdAt,
      this.updatedAt});

  VoucherRes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    maxBill = json['max_bill'];
    minBill = json['min_bill'];
    content = json['content'];
    title = json['title'];
    code = json['code'];
    expiredAt = json['expired_at'];
    number = json['number'];
    img = json['img'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['max_bill'] = this.maxBill;
    data['min_bill'] = this.minBill;
    data['content'] = this.content;
    data['title'] = this.title;
    data['code'] = this.code;
    data['expired_at'] = this.expiredAt;
    data['number'] = this.number;
    data['img'] = this.img;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}