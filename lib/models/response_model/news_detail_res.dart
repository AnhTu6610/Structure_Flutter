class NewsDetailRes {
  int code;
  NewsDetail data;
  String mess;

  NewsDetailRes({this.code, this.data, this.mess});

  NewsDetailRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new NewsDetail.fromJson(json['data']) : null;
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

class NewsDetail {
  String sId;
  String image;
  String content;
  String title;
  String short_content;
  String createdAt;
  String updatedAt;

  NewsDetail(
      {this.sId,
      this.image,
      this.content,
      this.short_content,
      this.title,
      this.createdAt,
      this.updatedAt});

  NewsDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['img'];
    content = json['content'];
    short_content = json['short_content'];
    title = json['title'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['img'] = this.image;
    data['content'] = this.content;
    data['short_content'] = this.short_content;
    data['title'] = this.title;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
