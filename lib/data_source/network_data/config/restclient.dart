import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mime/mime.dart';
import 'package:structure_example/data_source/local_data/preference_provider.dart';
import 'package:structure_example/data_source/network_data/config/apisubdomain.dart';
import 'package:structure_example/data_source/network_data/config/network_response.dart';
import 'package:structure_example/main.dart';
import 'package:structure_example/resource/mess_data.dart';
import 'package:structure_example/utils/log_debug.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

mixin RestClient {
  final String domain = API.domain;
  final Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json"};

  Future<NetworkResponse> getAsync(String pathURL, {Map<String, String> query}) async {
    NetworkResponse networkResponse = new NetworkResponse();
    Exception exception = new Exception();
    try {
      log("");
      log(domain + pathURL, "GET");
      log(query.toString(), "Query Parameters");
      Uri uri = Uri.https(domain, pathURL, query);

      http.Response response = await http.get(uri, headers: headers);
      log(response.statusCode, "Status Code");
      log(response.body, "Response");
      networkResponse
        ..statusCode = response.statusCode
        ..body = jsonDecode(response.body) ?? response.body;
    } catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> postAsync(String pathURL, {dynamic body, Map<String, String> query, Map<String, String> header}) async {
    NetworkResponse networkResponse = new NetworkResponse();
    Exception exception = new Exception();
    if (header != null) headers.addAll(header);
    try {
      log("");
      log(domain + pathURL, "POST");
      log(query.toString(), "Query Parameters");
      log(body.toString(), "Body");
      log(headers.toString(), "Headers");
      Uri uri = Uri.https(domain, pathURL, query);
      http.Response response = await http.post(uri, headers: headers, body: body == null ? "" : jsonEncode(body));
      log(response.statusCode, "Status Code");
      log(response.body, "Response");
      networkResponse
        ..statusCode = response.statusCode
        ..body = jsonDecode(response.body) ?? response.body;
    } catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> getAsyncWithToken(String pathURL, {Map<String, String> query}) async {
    NetworkResponse networkResponse = new NetworkResponse();
    Exception exception = new Exception();
    String token = await PreferenceProvider.getToken();
    Map<String, String> mapToken = {HttpHeaders.authorizationHeader: "Bearer $token"};
    headers.addAll(mapToken);
    try {
      log("");
      log(domain + pathURL, "GET");
      log(query.toString(), "Query Parameters");
      log(token, "Bearer Token");
      Uri uri = Uri.https(domain, pathURL, query);
      http.Response response = await http.get(uri, headers: headers);
      log(response.statusCode, "Status Code");
      log(response.body, "Response");
      networkResponse
        ..statusCode = response.statusCode
        ..body = jsonDecode(response.body) ?? response.body;
    } catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> postAsyncWithToken(String pathURL, {dynamic body, Map<String, String> query}) async {
    NetworkResponse networkResponse = new NetworkResponse();
    Exception exception = new Exception();
    String token = await PreferenceProvider.getToken();
    Map<String, String> mapToken = {HttpHeaders.authorizationHeader: "Bearer $token"};
    headers.addAll(mapToken);
    try {
      log("");
      log(domain + pathURL, "POST");
      log(query.toString(), "Query Parameters");
      log(body.toString(), "Body");
      log(token, "Bearer Token");
      Uri uri = Uri.https(domain, pathURL, query);
      http.Response response = await http.post(uri, headers: headers, body: body == null ? "" : jsonEncode(body));
      log(response.statusCode, "Status Code");
      log(response.body, "Response");
      networkResponse
        ..statusCode = response.statusCode
        ..body = jsonDecode(response.body) ?? response.body;
    } catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> putAsyncWithToken(String pathURL, {Map<String, String> query, dynamic body}) async {
    NetworkResponse networkResponse = new NetworkResponse();
    Exception exception = new Exception();
    String token = await PreferenceProvider.getToken();
    Map<String, String> mapToken = {HttpHeaders.authorizationHeader: "Bearer $token"};
    headers.addAll(mapToken);
    try {
      log("");
      log(domain + pathURL, "PUT");
      log(query.toString(), "Query Parameters");
      log(body.toString(), "Body");
      log(token, "Bearer Token");
      Uri uri = Uri.https(domain, pathURL, query);
      http.Response response = await http.put(uri, headers: headers, body: body == null ? "" : jsonEncode(body));
      log(response.statusCode, "Status Code");
      log(response.body, "Response");
      networkResponse
        ..statusCode = response.statusCode
        ..body = jsonDecode(response.body) ?? response.body;
    } catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> postMultiPartFormDataAsyncWithToken<T>(String pathURL, Map<String, String> body, List<Map<String, File>> listFile,
      {Map<String, dynamic> query, Map<String, String> header}) async {
    NetworkResponse networkResponse = new NetworkResponse();
    Exception exception = new Exception();
    String token = await PreferenceProvider.getToken();
    try {
      var uri = Uri.https(domain, pathURL);
      var request = new MultipartRequest("POST", uri);
      request.headers.addAll({'Authorization': 'Bearer $token', 'Content-type': 'multipart/form-data'});
      if (header != null) request.headers.addAll(header);
      log("");
      log(domain + pathURL, "POST");
      log(query.toString(), "Query Parameters");
      log(body.toString(), "Body");
      log(token, "Bearer Token");
      for (var i = 0; i < listFile.length; i++) {
        var mime = lookupMimeType(listFile[i].values.first.path);
        MultipartFile file = await MultipartFile.fromPath(
          listFile[i].keys.first,
          listFile[i].values.first.path,
          filename: listFile[i].values.first.path.split("/")[listFile[i].values.first.path.split("/").length - 1],
          contentType: new MediaType.parse(mime),
        );
        request.files.add(file);
      }
      if (body != null) {
        request.fields.addAll(body);
      }

      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var jsonResult = jsonDecode(respStr);
      log(response.statusCode, "Status Code");
      log(jsonResult, "Response");
      networkResponse
        ..statusCode = response.statusCode
        ..body = jsonResult;
    } catch (e) {
      log(e, "ERROR Post Multi Part Form Data Async With Token");
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> putMultiPartFormDataAsyncWithToken<T>(String pathURL, Map<String, String> body, List<Map<String, File>> listFile,
      {Map<String, dynamic> query, Map<String, String> header}) async {
    NetworkResponse networkResponse = new NetworkResponse();
    Exception exception = new Exception();
    String token = await PreferenceProvider.getToken();
    try {
      var uri = Uri.https(domain, pathURL);
      var request = new MultipartRequest("PUT", uri);
      request.headers.addAll({'Authorization': 'Bearer $token', 'Content-type': 'multipart/form-data'});
      if (header != null) request.headers.addAll(header);
      log("");
      log(domain + pathURL, "PUT");
      log(query.toString(), "Query Parameters");
      log(body.toString(), "Body");
      log(token, "Bearer Token");
      for (var i = 0; i < listFile.length; i++) {
        MultipartFile file = await MultipartFile.fromPath(
          listFile[i].keys.first,
          listFile[i].values.first.path,
          filename: listFile[i].values.first.path.split("/")[listFile[i].values.first.path.split("/").length - 1],
          contentType: new MediaType("image", "jpeg"),
        );
        request.files.add(file);
      }
      if (body != null) {
        request.fields.addAll(body);
      }

      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var jsonResult = jsonDecode(respStr);
      log(response.statusCode, "Status Code");
      log(jsonResult, "Response");
      networkResponse
        ..statusCode = response.statusCode
        ..body = jsonResult;
    } catch (e) {
      log(e, "ERROR Post Multi Part Form Data Async With Token");
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  processResponse(NetworkResponse networkResponse, Exception exception) {
    if (networkResponse.statusCode >= 200 && networkResponse.statusCode < 404) {
      networkResponse.isSuccess = true;
      networkResponse.message = "";
      return networkResponse;
    }
    if (exception != null) {
      log(exception, "Exception <--|");
      if (exception is SocketException) {
        networkResponse.networkEXC = NetworkException.NoInternet;
        networkResponse.message = MessData.errorInternet;
        return networkResponse;
      }
      if (exception is HttpException) {
        networkResponse.networkEXC = NetworkException.NoServiceFound;
        networkResponse.message = MessData.noServiceFound;
        return networkResponse;
      }
      if (exception is FormatException) {
        networkResponse.networkEXC = NetworkException.InvalidFormat;
        networkResponse.message = MessData.invalidFormat;
        return networkResponse;
      }
      if (exception is TimeoutException) {
        networkResponse.networkEXC = NetworkException.Timeout;
        networkResponse.message = MessData.connectTimeout;
        return networkResponse;
      }
    }
    // statusCode case token die
    if (networkResponse.statusCode == 400) {
      popToLogin();
      networkResponse.networkEXC = NetworkException.TokenDie;
      networkResponse.message = MessData.tokenDie;
      return networkResponse;
    }
    networkResponse.networkEXC = NetworkException.Unknown;
    networkResponse.message = MessData.errorUnknown;
    return networkResponse;
  }

  void popToLogin() {
    Future.delayed(Duration(milliseconds: 200), () {
      if (StateManager.navigatorKey.currentState.canPop()) {
        StateManager.navigatorKey.currentState.pushNamedAndRemoveUntil("/login", (route) => false, arguments: {"tokendie": true});
      }
    });
  }
}
