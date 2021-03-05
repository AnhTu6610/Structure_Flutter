import 'dart:io';

import 'package:structure_example/data_source/network_data/config/apisubdomain.dart';
import 'package:structure_example/data_source/network_data/config/network_response.dart';
import 'package:structure_example/data_source/network_data/config/restclient.dart';
import 'package:structure_example/data_source/network_data/interface/profile_api_provider.dart';
import 'package:structure_example/models/response_model/profile_res.dart';

class ProfileRepository with RestClient, ProfileApiProvider {
  @override
  Future<NetworkResponse> getprofile() async => getAsyncWithToken(API.profile);

  @override
  Future<NetworkResponse> updateProfile(DataProfileRes profile, List<Map<String, File>> listFile) async {
    Map<String, String> body = {};
    if (profile.fullname.isNotEmpty) body.addAll({"fullname": profile.fullname});
    if (profile.phone.isNotEmpty) body.addAll({"phone_number": profile.phone});
    if (profile.email.isNotEmpty) body.addAll({"email": profile.email});
    if (profile.email.isNotEmpty) body.addAll({"gender": profile.gender.toString()});
    return putMultiPartFormDataAsyncWithToken(API.updateProfile, body, listFile);
  }
}
