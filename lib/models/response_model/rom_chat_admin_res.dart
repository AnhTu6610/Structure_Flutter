import 'package:structure_example/models/base_model/mess_chat_model.dart';

class RomChatAdminRes {
  int code;
  DataRoom data;
  String mess;

  RomChatAdminRes({this.code, this.data, this.mess});

  RomChatAdminRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new DataRoom.fromJson(json['data']) : null;
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

class DataRoom {
  Room room;
  List<MessChatModel> data;

  DataRoom({this.room, this.data});

  DataRoom.fromJson(Map<String, dynamic> json) {
    room = json['room'] != null ? new Room.fromJson(json['room']) : null;
    if (json['data'] != null) {
      data = new List<MessChatModel>();
      json['data'].forEach((v) {
        data.add(new MessChatModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.room != null) {
      data['room'] = this.room.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Room {
  String sId;
  String userId;
  String createdAt;
  String updatedAt;
  String userSocket;

  Room({this.sId, this.userId, this.createdAt, this.updatedAt, this.userSocket});

  Room.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userSocket = json['user_socket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['user_socket'] = this.userSocket;
    return data;
  }
}
