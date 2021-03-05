class ListOrderRes {
  int code;
  DataListOrderRes data;
  String mess;

  ListOrderRes({this.code, this.data, this.mess});

  ListOrderRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new DataListOrderRes.fromJson(json['data']) : null;
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

class DataListOrderRes {
  int limit;
  int page;
  int totalResult;
  List<OrderRes> data;

  DataListOrderRes({this.limit, this.page, this.totalResult, this.data});

  DataListOrderRes.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    page = json['page'];
    totalResult = json['total_result'];
    if (json['data'] != null) {
      data = new List<OrderRes>();
      json['data'].forEach((v) {
        data.add(new OrderRes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['total_result'] = this.totalResult;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderRes {
  String sId;
  String receiver;
  String phoneReceiver;
  String address;
  String note;
  String typePayment;
  int totalMoney;
  String status;
  String userId;
  String createdAt;
  String updatedAt;
  List<Product> product;

  OrderRes({this.sId, this.receiver, this.phoneReceiver, this.address, this.note, this.typePayment, this.totalMoney, this.status, this.userId, this.createdAt, this.updatedAt, this.product});

  OrderRes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    receiver = json['receiver'];
    phoneReceiver = json['phone_receiver'];
    address = json['address'];
    note = json['note'];
    typePayment = json['type_payment'];
    totalMoney = json['total_money'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['Product'] != null) {
      product = new List<Product>();
      json['Product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['receiver'] = this.receiver;
    data['phone_receiver'] = this.phoneReceiver;
    data['address'] = this.address;
    data['note'] = this.note;
    data['type_payment'] = this.typePayment;
    data['total_money'] = this.totalMoney;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.product != null) {
      data['Product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String sId;
  int priceDiscount;
  List<String> idCategory;
  bool status;
  String subContent;
  String name;
  int price;
  String avatar;
  String createdAt;
  String updatedAt;
  int amount;

  Product({this.sId, this.priceDiscount, this.idCategory, this.status, this.subContent, this.name, this.price, this.avatar, this.createdAt, this.updatedAt, this.amount});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    priceDiscount = json['price_discount'];
    idCategory = json['id_category'].cast<String>();
    status = json['status'];
    subContent = json['sub_content'];
    name = json['name'];
    price = json['price'];
    avatar = json['avatar'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['price_discount'] = this.priceDiscount;
    data['id_category'] = this.idCategory;
    data['status'] = this.status;
    data['sub_content'] = this.subContent;
    data['name'] = this.name;
    data['price'] = this.price;
    data['avatar'] = this.avatar;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['amount'] = this.amount;
    return data;
  }
}
