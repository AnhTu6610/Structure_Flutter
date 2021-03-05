import 'dart:io';

import 'package:structure_example/data_source/network_data/config/apisubdomain.dart';
import 'package:structure_example/data_source/network_data/config/network_response.dart';
import 'package:structure_example/data_source/network_data/interface/authen_api_provider.dart';

import 'config/restclient.dart';

class AuthenRepository with RestClient, AuthenApiProvider {
  @override
  Future<NetworkResponse> login(String phone, String password) async {
    dynamic body = {"phone_number": phone, "password": password};
    return await postAsync(API.login, body: body);
  }

  @override
  Future<NetworkResponse> loginFacebook(String accessToken) async {
    dynamic body = {"access_token": accessToken};
    return await postAsync(API.loginFacbook, body: body);
  }

  @override
  Future<NetworkResponse> loginGoogle(String accessToken) async {
    dynamic body = {"access_token": accessToken};
    return await postAsync(API.loginGoogle, body: body);
  }

  @override
  Future<NetworkResponse> register(String fullname, String phone, String password, bool gender) async {
    dynamic body = {"fullname": fullname, "phone_number": phone, "password": password, "gender": gender};
    return await postAsync(API.registerUser, body: body);
  }

  @override
  Future<NetworkResponse> forgetPassword(String phone) async {
    Map<String, String> query = {"phone_number": phone};
    return await postAsync(API.forgetPassword, query: query);
  }

  @override
  Future<NetworkResponse> verifiedOtp(String phone, int otp, String tokenOTP) async {
    dynamic body = {"phone_number": phone, "otp": otp, "token": tokenOTP};
    return await postAsync(API.verifiedUser, body: body);
  }

  @override
  Future<NetworkResponse> changePassNotOTP(String oldPass, String newPass) async {
    dynamic body = {"old_password": oldPass, "new_password": newPass};
    return await postAsyncWithToken(API.changePassword, body: body);
  }

  @override
  Future<NetworkResponse> changePassOTP(String newPass) async {
    dynamic body = {"new_password": newPass};
    return await postAsyncWithToken(API.otpChangePassword, body: body);
  }

  @override
  Future<NetworkResponse> updateProfileSocial(String phone, String password, String token) async {
    dynamic body = {"phone_number": phone, "password": password};
    Map<String, String> header = {HttpHeaders.authorizationHeader: "Bearer $token"};
    return await postAsync(API.updateProfileSocial, body: body, header: header);
  }
}
