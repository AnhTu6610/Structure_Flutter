import 'dart:io';

import 'package:structure_example/data_source/network_data/config/network_response.dart';

abstract class ChatApiProvider {
  Future<NetworkResponse> createChatAdmin();
  Future<NetworkResponse> uploadFile(Map<String, String> body, List<Map<String, File>> listFile);
}
