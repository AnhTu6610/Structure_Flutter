import 'dart:io';

import 'package:structure_example/data_source/network_data/config/network_response.dart';
import 'package:structure_example/models/response_model/profile_res.dart';

abstract class ProfileApiProvider {
  Future<NetworkResponse> getprofile();
  Future<NetworkResponse> updateProfile(DataProfileRes profile, List<Map<String, File>> listFile);
}
