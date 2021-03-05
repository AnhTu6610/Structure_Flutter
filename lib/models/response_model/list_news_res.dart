class ListNewsRes {
  int code;
  DataListNewsRes data;
  String mess;

  ListNewsRes({this.code, this.data, this.mess});

  ListNewsRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new DataListNewsRes.fromJson(json['data']) : null;
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

class DataListNewsRes {
  int limit;
  int page;
  int totalResult;
  List<NewsRes> listNews;

  DataListNewsRes({this.limit, this.page, this.totalResult, this.listNews});

  DataListNewsRes.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    page = json['page'];
    totalResult = json['total_result'];
    if (json['data'] != null) {
      listNews = new List<NewsRes>();
      json['data'].forEach((v) {
        listNews.add(new NewsRes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['total_result'] = this.totalResult;
    if (this.listNews != null) {
      data['data'] = this.listNews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsRes {
  String sId;
  String img;
  String title;
  String createdAt;

  NewsRes({this.sId, this.img, this.title, this.createdAt});

  NewsRes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    img = json['img'];
    title = json['title'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['img'] = this.img;
    data['title'] = this.title;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
