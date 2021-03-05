import 'package:structure_example/models/response_model/product_detail_res.dart';

class ListProductRes {
  int code;
  DataListProductRes data;
  String mess;

  ListProductRes({this.code, this.data, this.mess});

  ListProductRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new DataListProductRes.fromJson(json['data']) : null;
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

class DataListProductRes {
  int limit;
  int page;
  int totalResult;
  List<Product> products;

  DataListProductRes({this.limit, this.page, this.totalResult, this.products});

  DataListProductRes.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    page = json['page'];
    totalResult = json['total_result'];
    if (json['data'] != null) {
      products = new List<Product>();
      json['data'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['total_result'] = this.totalResult;
    if (this.products != null) {
      data['data'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
