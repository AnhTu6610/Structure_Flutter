class ListNotificationRes {
  int code;
  DataListNotificationRes data;
  String mess;

  ListNotificationRes({this.code, this.data, this.mess});

  ListNotificationRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new DataListNotificationRes.fromJson(json['data']) : null;
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

class DataListNotificationRes {
  int limit;
  int page;
  int totalResult;
  List<NotificationRes> data;

  DataListNotificationRes({this.limit, this.page, this.totalResult, this.data});

  DataListNotificationRes.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    page = json['page'];
    totalResult = json['total_result'];
    if (json['data'] != null) {
      data = new List<NotificationRes>();
      json['data'].forEach((v) {
        data.add(new NotificationRes.fromJson(v));
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

class NotificationRes {
  String sId;
  bool isSend;
  String title;
  String subTitle;
  String content;
  String timeSend;
  String createdAt;
  String updatedAt;

  NotificationRes(
      {this.sId,
      this.isSend,
      this.title,
      this.subTitle,
      this.content,
      this.timeSend,
      this.createdAt,
      this.updatedAt});

  NotificationRes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isSend = json['is_send'];
    title = json['title'];
    subTitle = json['sub_title'];
    content = json['content'];
    timeSend = json['time_send'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['is_send'] = this.isSend;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['content'] = this.content;
    data['time_send'] = this.timeSend;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}