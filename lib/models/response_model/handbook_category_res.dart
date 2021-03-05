class ListCategoryHandBook {
  int code;
  List<CategoryHandBook> data;
  String mess;

  ListCategoryHandBook({this.code, this.data, this.mess});

  ListCategoryHandBook.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<CategoryHandBook>();
      json['data'].forEach((v) {
        data.add(new CategoryHandBook.fromJson(v));
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

class CategoryHandBook {
  bool delete;
  String sId;
  String name;
  String type;

  CategoryHandBook({this.delete, this.sId, this.name, this.type});

  CategoryHandBook.fromJson(Map<String, dynamic> json) {
    delete = json['delete'];
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delete'] = this.delete;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}