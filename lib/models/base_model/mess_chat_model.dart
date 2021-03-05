class MessChatModel {
  String type;
  String status;
  String sId;
  String roomId;
  String message;
  String userId;
  String createdAt;
  String updatedAt;

  MessChatModel({this.type, this.status, this.sId, this.roomId, this.message, this.userId, this.createdAt, this.updatedAt});

  MessChatModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    status = json['status'];
    sId = json['_id'];
    roomId = json['room_id'];
    message = json['message'];
    userId = json['user_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['room_id'] = this.roomId;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
