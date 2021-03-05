class ListNewsHightLightRes {
  int code;
  ListDataNewsHightLightRes data;
  String mess;

  ListNewsHightLightRes({this.code, this.data, this.mess});

  ListNewsHightLightRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new ListDataNewsHightLightRes.fromJson(json['data']) : null;
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

class ListDataNewsHightLightRes {
  int limit;
  int page;
  List<NewsHightLightRes> data;

  ListDataNewsHightLightRes({this.limit, this.page, this.data});

  ListDataNewsHightLightRes.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    page = json['page'];
    if (json['data'] != null) {
      data = new List<NewsHightLightRes>();
      json['data'].forEach((v) {
        data.add(new NewsHightLightRes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['page'] = this.page;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsHightLightRes {
  String sId;
  // List<String> idCategory;
  String author;
  String content;
  String title;
  String shortContent;
  String img;
  String createdAt;
  String updatedAt;

  NewsHightLightRes(
      {this.sId,
      // this.idCategory,
      this.author,
      this.content,
      this.title,
      this.shortContent,
      this.img,
      this.createdAt,
      this.updatedAt});

  NewsHightLightRes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    // idCategory = json['id_category'].cast<String>();
    author = json['author'];
    content = json['content'];
    title = json['title'];
    shortContent = json['short_content'];
    img = json['img'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    // data['id_category'] = this.idCategory;
    data['author'] = this.author;
    data['content'] = this.content;
    data['title'] = this.title;
    data['short_content'] = this.shortContent;
    data['img'] = this.img;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
