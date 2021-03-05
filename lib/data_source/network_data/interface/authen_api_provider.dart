import 'package:structure_example/data_source/network_data/config/network_response.dart';

abstract class AuthenApiProvider {
  Future<NetworkResponse> login(String phone, String password);
  Future<NetworkResponse> loginGoogle(String accessToken);
  Future<NetworkResponse> loginFacebook(String accessToken);
  Future<NetworkResponse> register(String username, String phone, String password, bool gender);
  Future<NetworkResponse> forgetPassword(String phone);
  Future<NetworkResponse> verifiedOtp(String phone, int otp, String tokenOTP);
  Future<NetworkResponse> changePassOTP(String newPass);
  Future<NetworkResponse> changePassNotOTP(String oldPass, String newPass);
  Future<NetworkResponse> updateProfileSocial(String phone, String password, String token);
}
