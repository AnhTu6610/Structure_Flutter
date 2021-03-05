class EventDetailRes {
  int code;
  EventDetail data;
  String mess;

  EventDetailRes({this.code, this.data, this.mess});

  EventDetailRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new EventDetail.fromJson(json['data']) : null;
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

class EventDetail {
  String sId;
  String image;
  String content;
  String title;
  String status;
  String time;
  String address;
  bool joined;
  EventDetail(
      {this.sId,
      this.image,
      this.content,
      this.status,
      this.title,
      this.address,
      this.time,
      this.joined});

  EventDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['img'];
    content = json['content'];
    address = json['address'];
    title = json['title'];
    time = json['time'];
    status = json['status'];
    joined = json['joined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['img'] = this.image;
    data['content'] = this.content;
    data['status'] = this.status;
    data['title'] = this.title;
    data['time'] = this.time;
    data['address'] = this.address;
    data['joined'] = this.joined;
    return data;
  }
}
