class CategoryProductRes {
  int code;
  List<CategoryProduct> data;
  String mess;

  CategoryProductRes({this.code, this.data, this.mess});

  CategoryProductRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<CategoryProduct>();
      json['data'].forEach((v) {
        data.add(new CategoryProduct.fromJson(v));
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

class CategoryProduct {
  bool delete;
  String sId;
  String name;
  String img;

  CategoryProduct({this.delete, this.sId, this.name, this.img});

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    delete = json['delete'];
    sId = json['_id'];
    name = json['name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delete'] = this.delete;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['img'] = this.img;
    return data;
  }
}
