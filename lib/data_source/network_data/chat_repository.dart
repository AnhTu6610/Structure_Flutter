import 'dart:io';

import 'package:structure_example/data_source/network_data/config/apisubdomain.dart';
import 'package:structure_example/data_source/network_data/config/network_response.dart';
import 'package:structure_example/data_source/network_data/config/restclient.dart';
import 'package:structure_example/data_source/network_data/interface/chat_api_provider.dart';

class ChatRepository with RestClient, ChatApiProvider {
  @override
  Future<NetworkResponse> createChatAdmin() async {
    return postAsyncWithToken(API.chatAdmin);
  }

  @override
  Future<NetworkResponse> uploadFile(Map<String, String> body, List<Map<String, File>> listFile) async {
    return postMultiPartFormDataAsyncWithToken(API.uploadFileChat, body, listFile);
  }
}
