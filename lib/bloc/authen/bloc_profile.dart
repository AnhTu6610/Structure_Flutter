import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:structure_example/bloc/base_bloc/base_bloc.dart';
import 'package:structure_example/data_source/network_data/profile_repository.dart';
import 'package:structure_example/models/response_model/profile_res.dart';

class BlocProfile with BaseBloc, ChangeNotifier {
  ProfileRepository _profileRepository = new ProfileRepository();

  ProfileRes profile = new ProfileRes();

  // StreamController<ProfileRes> _profileController = new StreamController<ProfileRes>.broadcast();
  // Stream<ProfileRes> get profileStream => _profileController.stream;
  // Sink<ProfileRes> get profileSink => _profileController.sink;

  Future<bool> getProflie() async {
    try {
      var result = await _profileRepository.getprofile();
      if (result.isSuccess) {
        ProfileRes profileRes = ProfileRes.fromJson(result.body);
        // profileSink.add(result.bodyResponse);
        profile = profileRes;
        return true;
      } else
        await showError(result.message);
    } catch (e) {
      await showError("Vui lòng thử lại", exception: e);
    }
    return false;
  }

  Future updateInfo(String name, String phone, String email, bool gender, File file) async {
    List<Map<String, File>> listFile = [];
    if (file != null) listFile.add({"img": file});
    try {
      showLoading();
      var result = await _profileRepository.updateProfile(new DataProfileRes(fullname: name, phone: phone, email: email, gender: gender), listFile);
      if (result.isSuccess) {
        if (result.statusCode == 200) {
          await getProflie();
          notifyListeners();
          hideLoading();
          return true;
        }
        if (result.statusCode == 400) {
          showError("Số điện thoại đã được đăng ký");
          hideLoading();
          return false;
        }
        throw result.body;
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    return false;
  }

  @override
  dispose() {
    super.dispose();
    // _profileController.close();
  }
}
