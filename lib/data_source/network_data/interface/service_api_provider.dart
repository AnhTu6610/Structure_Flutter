import 'package:structure_example/data_source/network_data/config/network_response.dart';

abstract class ServiceApiProvider {
  Future<NetworkResponse> updateFcm(String tokenFcm);
}
