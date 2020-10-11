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
  final Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json"
  };
  Future<NetworkResponse> getAsync(String pathURL,
      [Map<String, dynamic> params]) async {
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

  Future<NetworkResponse> getAsyncWithToken(String pathURL,
      [Map<String, dynamic> params]) async {
    NetworkResponse networkResponse = new NetworkResponse();
    Exception exception = new Exception();
    String token = await PreferenceProvider.getToken();
    Map<String, String> mapToken = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
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

  processResponse(NetworkResponse networkResponse, Exception exception) {
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
    if (networkResponse.statusCode >= 200 && networkResponse.statusCode < 401) {
      networkResponse.isSuccess = true;
      return networkResponse;
    }
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
        MyApp.navigatorKey.currentState.pushNamedAndRemoveUntil(
            "/login", (route) => false,
            arguments: {"tokendie": true});
      }
    });
  }

  // Future<MappedNetworkServiceResponse<T>> getAsync<T>(String resourcePath,
  //     [Map<String, dynamic> query]) async {
  //   var url = Uri.http(baseUrl, resourcePath, query);
  //   print("URL: " + baseUrl + resourcePath);
  //   print("Params: " + query.toString());
  //   var response = await http.get(url).timeout(const Duration(seconds: 30));
  //   print("--> GET SPONSE OF " + url.path + "\n" + response.body);
  //   return processResponse<T>(response);
  // }

  // Future<MappedNetworkServiceResponse<T>> getAsyncToken<T>(String resourcePath,
  //     [Map<String, dynamic> params]) async {
  //   var token;
  //   await PreferenceProvider.getToken().then((result) {
  //     token = result;
  //   });
  //   Map<String, String> mapToken = {
  //     // HttpHeaders.authorizationHeader: "Bearer $token"
  //     "token": "$token"
  //   };
  //   headers.addAll(mapToken);
  //   var url = Uri.http(baseUrl, resourcePath, params);
  //   print("URL: " + baseUrl + resourcePath);
  //   print("Params: " + params.toString());
  //   print("Bearer: " + token);
  //   var response = await http
  //       .get(url, headers: headers)
  //       .timeout(const Duration(seconds: 30));

  //   print("--> GET SPONSE OF " + url.path + "\n" + response.body);
  //   return processResponse<T>(response);
  // }

  // Future<MappedNetworkServiceResponse<T>> postAsync<T>(
  //     String resourcePath, dynamic data,
  //     [Map<String, dynamic> query]) async {
  //   var url = Uri.http(baseUrl, resourcePath, query);
  //   print("URL: " + baseUrl + resourcePath);
  //   print("DATA: " + data.toString());
  //   print("Params: " + query.toString());

  //   var client = http.Client();
  //   try {
  //     var response = await client
  //         .post(url, body: json.encode(data), headers: headers)
  //         .timeout(const Duration(seconds: 30));
  //     print("--> POST SPONSE OF " + url.path + "\n" + response.body);
  //     return processResponse<T>(response);
  //   } finally {
  //     client.close();
  //   }
  // }

  // Future<MappedNetworkServiceResponse<T>> postAsyncWithToken<T>(
  //     String resourcePath, dynamic data,
  //     [Map<String, dynamic> query]) async {
  //   // var content = json.encoder.convert(data);
  //   var token;
  //   await PreferenceProvider.getToken().then((result) {
  //     token = result;
  //   });
  //   var url = Uri.http(baseUrl, resourcePath, query);
  //   print("URL: " + baseUrl + resourcePath);
  //   print("DATA: " + data.toString());
  //   print("Params: " + query.toString());
  //   print("TOKEN: " + token);
  //   Map<String, String> mapToken = {
  //     // HttpHeaders.authorizationHeader: "Bearer $token"
  //     "token": "$token"
  //   };
  //   headers.addAll(mapToken);

  //   // print("--> POST\n---> HEADER: $headers" + "\n---> body: " + data);
  //   var response =
  //       await http.post(url, body: json.encode(data), headers: headers);
  //   print(response.request.url);
  //   print("--> POST SPONSE OF " + url.path + "\n" + response.body);
  //   return processResponse<T>(response);
  // }

  // Future<MappedNetworkServiceResponse<T>> putAsyncWithToken<T>(
  //     String resourcePath, dynamic data,
  //     [Map<String, dynamic> query]) async {
  //   // var content = json.encoder.convert(data);
  //   var token;
  //   await PreferenceProvider.getToken().then((result) {
  //     token = result;
  //   });
  //   var url = Uri.http(baseUrl, resourcePath, query);
  //   print("URL: " + baseUrl + resourcePath);
  //   print("Params: " + json.encode(data).toString());
  //   print("DATA: " + data.toString());
  //   Map<String, String> mapToken = {
  //     // HttpHeaders.authorizationHeader: "Bearer $token"
  //     "token": "$token"
  //   };
  //   headers.addAll(mapToken);

  //   // print("--> POST\n---> HEADER: $headers" + "\n---> body: " + data);

  //   var response =
  //       await http.put(url, body: json.encode(data), headers: headers);
  //   print(response.request.url);
  //   print(response.statusCode);
  //   print("--> POST SPONSE OF " + url.path + "\n" + response.body);
  //   return processResponse<T>(response);
  // }

  // MappedNetworkServiceResponse<T> processResponse<T>(http.Response response) {
  //   print("<- httpcode: ${response.statusCode} ->");
  //   if (!((response.statusCode < 200) ||
  //       (response.statusCode >= 300) ||
  //       (response.body == null))) {
  //     var jsonResult = response.body;
  //     var resultClass = jsonDecode(jsonResult);

  //     return MappedNetworkServiceResponse<T>(
  //         mappedResult: resultClass,
  //         networkServiceResponse: NetworkServiceResponse<T>(
  //           httpCode: response.statusCode,
  //           isSuccess: true,
  //         ));
  //   } else {
  //     try {
  //       var resultJson = jsonDecode(response.body);
  //       var result = ErrorServerResponse.fromJson(resultJson);
  //       if (response.statusCode == 401) {
  //         popToLogin();
  //         return null;
  //       }
  //       return MappedNetworkServiceResponse<T>(
  //           mappedResult: jsonDecode(response.body),
  //           networkServiceResponse: NetworkServiceResponse<T>(
  //               httpCode: response.statusCode,
  //               isSuccess: false,
  //               message: result.message));
  //     } catch (e) {
  //       print(e);
  //       return MappedNetworkServiceResponse<T>(
  //           networkServiceResponse: NetworkServiceResponse<T>(
  //               httpCode: response.statusCode,
  //               isSuccess: false,
  //               message: "Có lỗi. Vui lòng thử lại sau!"));
  //     }
  //   }
  // }

}
