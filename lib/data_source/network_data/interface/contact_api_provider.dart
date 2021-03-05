import 'package:structure_example/data_source/network_data/config/network_response.dart';

abstract class ContactApiProvider {
  Future<NetworkResponse> getListContact(String limit, String page);
}
