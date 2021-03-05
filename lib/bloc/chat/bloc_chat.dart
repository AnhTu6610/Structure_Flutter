import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:structure_example/bloc/base_bloc/base_bloc.dart';
import 'package:structure_example/data_source/local_data/preference_name.dart';
import 'package:structure_example/data_source/local_data/preference_provider.dart';
import 'package:structure_example/data_source/network_data/chat_repository.dart';
import 'package:structure_example/data_source/network_data/config/apisubdomain.dart';
import 'package:structure_example/models/base_model/mess_chat_model.dart';
import 'package:structure_example/models/response_model/rom_chat_admin_res.dart';
import 'package:structure_example/utils/log_debug.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:structure_example/utils/validators.dart';

class BlocChat extends BaseBloc with ChangeNotifier {
  ChatRepository _chatRepository = new ChatRepository();
  Socket socketAdmin;
  String idRoom;

  StreamController<List<MessChatModel>> _chatAdmincontroller = StreamController<List<MessChatModel>>.broadcast();
  Stream<List<MessChatModel>> get chatAdminStream => _chatAdmincontroller.stream;
  Sink<List<MessChatModel>> get chatAdminSink => _chatAdmincontroller.sink;
  List<MessChatModel> listMess = [];
  StreamController<bool> loadUpload = StreamController<bool>.broadcast();

  Future connectChatAdmin() async {
    if (socketAdmin == null) {
      var result = await getRoomAdmin();
      if (result == true) {
        String token = await PreferenceProvider.getString(PreferenceNames.TOKEN);
        socketAdmin = io('wss://${API.domain}/chat-client?id=$idRoom&token=$token', <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': true,
        });
        socketAdmin.connect();
        socketAdmin.onConnect((_) {
          log('socket connected');
        });
        socketAdmin.on('chat', (data) {
          MessChatModel newsMess = MessChatModel.fromJson(data);
          this.listMess.insert(0, newsMess);
          chatAdminSink.add(this.listMess);
        });
      }
    }
  }

  disconnectChat() {
    socketAdmin.disconnect();
  }

  sendChatAdminMess(dynamic mess, String type) {
    if (mess != '' && socketAdmin.connected == true) {
      dynamic data = {"message": "$mess", "status": type};
      socketAdmin.emit('chat', data);
    }
  }

  Future getRoomAdmin() async {
    try {
      loadUpload.sink.add(true);
      var result = await _chatRepository.createChatAdmin();
      if (result.isSuccess) {
        RomChatAdminRes room = RomChatAdminRes.fromJson(result.body);
        this.idRoom = room.data.room.sId;
        this.listMess = room.data.data;
        chatAdminSink.add(this.listMess);

        loadUpload.sink.add(false);
        return true;
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    loadUpload.sink.add(false);
    return false;
  }

  Future sendImage(File file) async {
    List<Map<String, File>> listFile = [];
    listFile.add({"img": file});

    try {
      loadUpload.sink.add(true);
      var result = await _chatRepository.uploadFile(null, listFile);
      if (result.isSuccess) {
        String link = result.body['data']['url'].toString();
        sendChatAdminMess(link, link.isImgUrl() ? "img" : "file");
        hideLoading();
        loadUpload.sink.add(false);
        return true;
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    loadUpload.sink.add(true);
    return false;
  }
}
