import 'dart:io';

import 'package:structure_example/data_source/network_data/config/apisubdomain.dart';
import 'package:structure_example/data_source/network_data/config/network_response.dart';
import 'package:structure_example/data_source/network_data/config/restclient.dart';
import 'package:structure_example/data_source/network_data/interface/service_api_provider.dart';

class ServiceRepository with RestClient, ServiceApiProvider {
  @override
  Future<NetworkResponse> updateFcm(String tokenFcm) async {
    dynamic body = {"fcm": tokenFcm, "os": Platform.isAndroid ? "ANDROID" : "IOS"};
    await postAsyncWithToken(API.updateFCM, body: body);
  }
}
