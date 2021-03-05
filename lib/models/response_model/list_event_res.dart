class ListEventRes {
  int code;
  DataEventRes data;
  String mess;

  ListEventRes({this.code, this.data, this.mess});

  ListEventRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data =
        json['data'] != null ? new DataEventRes.fromJson(json['data']) : null;
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

class DataEventRes {
  int limit;
  int page;
  int totalResult;
  List<EventRes> events;

  DataEventRes({this.limit, this.page, this.totalResult, this.events});

  DataEventRes.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    page = json['page'];
    totalResult = json['total_result'];
    if (json['data'] != null) {
      events = new List<EventRes>();
      json['data'].forEach((v) {
        events.add(new EventRes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['total_result'] = this.totalResult;
    if (this.events != null) {
      data['data'] = this.events.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventRes {
  String sId;
  String status;
  String title;
  String img;
  String address;
  String time;
  bool joined;

  EventRes(
      {this.sId, this.img, this.title, this.status, this.address, this.time,this.joined});

  EventRes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    img = json['img'];
    title = json['title'];
    address = json['address'];
    status = json['status'];
    time = json['time'];
    joined =json['joined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['img'] = this.img;
    data['title'] = this.title;
    data['time'] = this.time;
    data['address'] = this.address;
    data['status'] = this.status;
    data['joined'] = this.joined;
    return data;
  }
}
