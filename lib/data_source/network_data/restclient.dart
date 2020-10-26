import 'dart:async';
import 'dart:io';
import 'package:structure_example/data_source/local_data/preference_provider.dart';
import 'package:structure_example/data_source/network_data/apisubdomain.dart';
import 'package:structure_example/data_source/network_data/network_response.dart';
import 'package:structure_example/main.dart';
import 'package:structure_example/utils/debug_print.dart';
import 'package:http/http.dart' as http;

mixin RestClient {
  final String domain = API.domain;
  final Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json"};
  Future<NetworkResponse> getAsync(String pathURL, [Map<String, dynamic> params]) async {
    NetworkResponse networkResponse = new NetworkResponse();
    Exception exception = new Exception();
    try {
      debugPrint(domain + pathURL, "GET");
      debugPrint(params.toString(), "Params");
      Uri uri = Uri.http(domain, pathURL, params);
      http.Response response = await http.get(uri);
      debugPrint(response.statusCode, "Status Code");
      debugPrint(response.body, "Response");
      networkResponse
        ..statusCode = response.statusCode
        ..body = response.body;
    } catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> postAsync(String pathURL, [Map<String, dynamic> params]) async {
    NetworkResponse networkResponse = new NetworkResponse();
    Exception exception = new Exception();
    try {
      debugPrint(domain + pathURL, "GET");
      debugPrint(params.toString(), "Params");
      Uri uri = Uri.http(domain, pathURL, params);
      http.Response response = await http.post(uri);
      debugPrint(response.statusCode, "Status Code");
      debugPrint(response.body, "Response");
      networkResponse
        ..statusCode = response.statusCode
        ..body = response.body;
    } catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> getAsyncWithToken(String pathURL, [Map<String, dynamic> params]) async {
    NetworkResponse networkResponse = new NetworkResponse();
    Exception exception = new Exception();
    String token = await PreferenceProvider.getToken();
    Map<String, String> mapToken = {HttpHeaders.authorizationHeader: "Bearer $token"};
    headers.addAll(mapToken);
    try {
      debugPrint(domain + pathURL, "GET");
      debugPrint(params.toString(), "Params");
      debugPrint(token, "Bearer Token");
      Uri uri = Uri.http(domain, pathURL, params);
      http.Response response = await http.get(uri, headers: headers);
      debugPrint(response.statusCode, "Status Code");
      debugPrint(response.body, "Response");
      networkResponse
        ..statusCode = response.statusCode
        ..body = response.body;
    } catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> postAsyncWithToken(String pathURL, [Map<String, dynamic> params, Map<String, dynamic> body]) async {
    NetworkResponse networkResponse = new NetworkResponse();
    Exception exception = new Exception();
    String token = await PreferenceProvider.getToken();
    Map<String, String> mapToken = {HttpHeaders.authorizationHeader: "Bearer $token"};
    headers.addAll(mapToken);
    try {
      debugPrint(domain + pathURL, "GET");
      debugPrint(params.toString(), "Params");
      debugPrint(body.toString(), "Body");
      debugPrint(token, "Bearer Token");
      Uri uri = Uri.http(domain, pathURL, params);
      http.Response response = await http.post(uri, headers: headers, body: body);
      debugPrint(response.statusCode, "Status Code");
      debugPrint(response.body, "Response");
      networkResponse
        ..statusCode = response.statusCode
        ..body = response.body;
    } catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> putAsyncWithToken(String pathURL, [Map<String, dynamic> params, Map<String, dynamic> body]) async {
    NetworkResponse networkResponse = new NetworkResponse();
    Exception exception = new Exception();
    String token = await PreferenceProvider.getToken();
    Map<String, String> mapToken = {HttpHeaders.authorizationHeader: "Bearer $token"};
    headers.addAll(mapToken);
    try {
      debugPrint(domain + pathURL, "GET");
      debugPrint(params.toString(), "Params");
      debugPrint(body.toString(), "Body");
      debugPrint(token, "Bearer Token");
      Uri uri = Uri.http(domain, pathURL, params);
      http.Response response = await http.put(uri, headers: headers, body: body);
      debugPrint(response.statusCode, "Status Code");
      debugPrint(response.body, "Response");
      networkResponse
        ..statusCode = response.statusCode
        ..body = response.body;
    } catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  processResponse(NetworkResponse networkResponse, Exception exception) {
    debugPrint(exception, "Exception <--|");
    if (exception is SocketException) {
      networkResponse.networkEXC = NetworkException.NoInternet;
      return networkResponse;
    }
    if (exception is HttpException) {
      networkResponse.networkEXC = NetworkException.NoServiceFound;
      return networkResponse;
    }
    if (exception is FormatException) {
      networkResponse.networkEXC = NetworkException.InvalidFormat;
      return networkResponse;
    }
    if (exception is TimeoutException) {
      networkResponse.networkEXC = NetworkException.Timeout;
      return networkResponse;
    }
    if (networkResponse.statusCode >= 200 && networkResponse.statusCode < 401) {
      networkResponse.isSuccess = true;
      return networkResponse;
    }
    // statusCode case token die
    if (networkResponse.statusCode == 401) {
      popToLogin();
      networkResponse.networkEXC = NetworkException.TokenDie;
      return networkResponse;
    }
    networkResponse.networkEXC = NetworkException.Unknown;
    return networkResponse;
  }

  void popToLogin() {
    Future.delayed(Duration(milliseconds: 200), () {
      if (MyApp.navigatorKey.currentState.canPop()) {
        MyApp.navigatorKey.currentState.pushNamedAndRemoveUntil("/login", (route) => false, arguments: {"tokendie": true});
      }
    });
  }
}
