class ProductDetailRes {
  int code;
  DataProductDetailRes data;
  String mess;

  ProductDetailRes({this.code, this.data, this.mess});

  ProductDetailRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new DataProductDetailRes.fromJson(json['data']) : null;
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

class DataProductDetailRes {
  Product productDetail;
  List<Product> productRelated;

  DataProductDetailRes({this.productDetail, this.productRelated});

  DataProductDetailRes.fromJson(Map<String, dynamic> json) {
    productDetail = json['detail'] != null ? new Product.fromJson(json['detail']) : null;
    if (json['list_related'] != null) {
      productRelated = new List<Product>();
      json['list_related'].forEach((v) {
        productRelated.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productDetail != null) {
      data['detail'] = this.productDetail.toJson();
    }
    if (this.productRelated != null) {
      data['list_related'] = this.productRelated.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String sId;
  List<String> image;
  int priceDiscount;
  String content;
  String sub_content;
  String name;
  int price;
  String avatar;
  String createdAt;
  String updatedAt;
  int amount;

  Product({this.sId, this.image, this.priceDiscount, this.content, this.sub_content, this.name, this.price, this.avatar, this.createdAt, this.updatedAt, this.amount = 1});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? json['id'];
    if (json['image'] != null) {
      image = new List<Null>();
      json['image'].forEach((v) {
        image.add(v);
      });
    }
    priceDiscount = json['price_discount'];
    content = json['content'];
    sub_content = json['sub_content'];
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
    if (this.image != null) {
      data['image'] = this.image.map((v) => v).toList();
    }
    data['price_discount'] = this.priceDiscount;
    data['content'] = this.content;
    data['sub_content'] = this.sub_content;
    data['name'] = this.name;
    data['price'] = this.price;
    data['avatar'] = this.avatar;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['amount'] = this.amount;
    return data;
  }
}
