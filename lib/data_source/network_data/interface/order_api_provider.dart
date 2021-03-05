import 'package:structure_example/data_source/network_data/config/network_response.dart';

abstract class OrderApiProvider {
  Future<NetworkResponse> getListOrder(String limit, String page, String status);
}
