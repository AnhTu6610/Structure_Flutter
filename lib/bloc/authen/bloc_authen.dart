import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:structure_example/bloc/base_bloc/base_bloc.dart';
import 'package:structure_example/data_source/local_data/preference_name.dart';
import 'package:structure_example/data_source/local_data/preference_provider.dart';
import 'package:structure_example/data_source/network_data/authen_repository.dart';
import 'package:structure_example/data_source/network_data/config/network_response.dart';
import 'package:structure_example/main.dart';
import 'package:structure_example/models/arguments_model/arg_register.dart';
import 'package:structure_example/models/response_model/login_res.dart';
import 'package:structure_example/utils/enum_value.dart';
import 'package:structure_example/utils/log_debug.dart';

class BlocAuthen extends BaseBloc {
  final AuthenRepository _authenRepository = new AuthenRepository();
  final FacebookLogin facebookLogin = FacebookLogin();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  String tokenOtp;

  Future signOut() async {
    await PreferenceProvider.removeAll();
    await _googleSignIn.signOut();
    await facebookLogin.logOut();
  }

  Future<StateAccount> loginPhone(String phone, String password) async {
    try {
      showLoading();
      NetworkResponse result = await _authenRepository.login(phone, password);

      if (result.isSuccess) {
        LoginRes loginRes = LoginRes.fromJson(result.body);
        if (loginRes.code == 0) {
          await PreferenceProvider.setString(PreferenceNames.TOKEN, loginRes.data.token);
          hideLoading();
          return StateAccount.VERIFY;
        }
        if (loginRes.code == 2) showError("Số điện thoại chưa được đăng ký");
        if (loginRes.code == 3) showError("Sai mật khẩu");
        if (loginRes.code == 4) {
          NetworkResponse resultForgot = await _authenRepository.forgetPassword(phone);
          if (resultForgot.isSuccess) {
            if (resultForgot.body['code'] == 0) {
              tokenOtp = resultForgot.body['data']['token'];
              hideLoading();
              return StateAccount.NOTVERIFY;
            }
          }
        }
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    hideLoading();
    return null;
  }

  Future<bool> handleLoginSocial(BuildContext context, LoginOption option) async {
    try {
      switch (option) {
        case LoginOption.GOOGLE:
          GoogleSignInAccount info = await _googleSignIn.signIn();

          String tokenGoogle = await info.authentication.then((value) => value.accessToken);
          log(tokenGoogle);
          return await fetchLoginSocial(tokenGoogle, LoginOption.GOOGLE);
        case LoginOption.FACEBOOK:
          FacebookLoginResult resFB = await facebookLogin.logIn(['email']);
          return await fetchLoginSocial(resFB.accessToken.token, LoginOption.FACEBOOK);
      }
    } catch (error) {
      log(error);
    }
    return false;
  }

  Future<bool> fetchLoginSocial(String accessToken, LoginOption loginOption) async {
    try {
      showLoading();
      NetworkResponse result = new NetworkResponse();
      if (loginOption == LoginOption.GOOGLE) {
        result = await _authenRepository.loginGoogle(accessToken);
      }
      if (loginOption == LoginOption.FACEBOOK) {
        result = await _authenRepository.loginFacebook(accessToken);
      }

      if (result.isSuccess) {
        LoginRes loginSocialRes = LoginRes.fromJson(result.body);
        if (loginSocialRes?.data?.isVerified == true) {
          await PreferenceProvider.setString(PreferenceNames.TOKEN, loginSocialRes.data.token);
          await PreferenceProvider.setBool(PreferenceNames.FIRST_INTRO, false);
          hideLoading();
          return true;
        } else {
          Navigator.of(StateManager.navigatorKey.currentContext).pushNamed("/update-profile-social", arguments: ArgUpdateProfileSocial(token: loginSocialRes.data.token));
        }
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    return false;
  }

  Future<int> getFirstLogin() async {
    return PreferenceProvider.getInt(PreferenceNames.FIRST_INTRO);
  }

  Future<StateAccount> register(String fullname, String phone, String password, bool gender) async {
    try {
      showLoading();
      var result = await _authenRepository.register(fullname, phone, password, gender);
      if (result.isSuccess) {
        if (result.body['code'] == 1) {
          NetworkResponse resultForgot = await _authenRepository.forgetPassword(phone);
          if (resultForgot.isSuccess) {
            if (resultForgot.body['code'] == 0) {
              tokenOtp = resultForgot.body['data']['token'];
              hideLoading();
              return StateAccount.NOTVERIFY;
            }
            if (resultForgot.body['code'] == 2) showError("Số điện thoại chưa được đăng ký");
          }
        }
        if (result.body['code'] == 0) {
          if (result.body['data']['is_verified'] == false) {
            tokenOtp = result.body['data']['_token'].toString();
            return StateAccount.NOTVERIFY;
          } else
            await showError("Số điện thoại này đã được đăng ký!");
        }
      } else
        await showError(result.message);
    } catch (e) {
      await showError("Vui lòng thử lại", exception: e);
    }
    return null;
  }

  Future verifiedOtp(String phone, String otp, String tokenOTP) async {
    try {
      showLoading();
      NetworkResponse result = await _authenRepository.verifiedOtp(phone, int.parse(otp), tokenOTP);
      if (result.isSuccess) {
        if (result.body['code'] == 0) {
          await PreferenceProvider.setString(PreferenceNames.TOKEN, result.body['data']['token']);
          hideLoading();
          return true;
        }

        showError("OTP không đúng, vui lòng thử lại");
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    return false;
  }

  Future forgetPass(String phone) async {
    try {
      showLoading();
      NetworkResponse resultForgot = await _authenRepository.forgetPassword(phone);
      if (resultForgot.isSuccess) {
        if (resultForgot.body['code'] == 0) {
          String tokenOtp = resultForgot.body['data']['token'];
          hideLoading();
          return tokenOtp;
        }
        if (resultForgot.body['code'] == 2) showError("Số điện thoại chưa được đăng ký");
      } else
        showError(resultForgot.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    return false;
  }

  Future<bool> changePassNotOTP(String oldPass, String newPass) async {
    try {
      showLoading();
      NetworkResponse resultForgot = await _authenRepository.changePassNotOTP(oldPass, newPass);
      if (resultForgot.isSuccess) {
        if (resultForgot.body['code'] == 0) {
          hideLoading();
          return true;
        }
        showError("Mật khẩu cũ không đúng");
      } else
        showError(resultForgot.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    return false;
  }

  Future<bool> changePassOTP(String newPass) async {
    try {
      showLoading();
      NetworkResponse resultForgot = await _authenRepository.changePassOTP(newPass);
      if (resultForgot.isSuccess) {
        hideLoading();
        return true;
      } else
        showError(resultForgot.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    return false;
  }

  Future<bool> updateProfileSocial(String phone, String password, String token) async {
    try {
      showLoading();
      NetworkResponse resultForgot = await _authenRepository.updateProfileSocial(phone, password, token);
      if (resultForgot.isSuccess && resultForgot.body["code"] == 0) {
        await PreferenceProvider.setString(PreferenceNames.TOKEN, token);
        hideLoading();
        return true;
      } else if (resultForgot.isSuccess && resultForgot.body["code"] == 3) {
        showError("Số điện thoại đã được đăng ký");
      } else
        showError(resultForgot.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    return false;
  }
}
