import 'package:structure_example/data_source/network_data/apisubdomain.dart';
import 'package:structure_example/data_source/network_data/network_response.dart';
import 'package:structure_example/data_source/network_data/restclient.dart';

class UserRepository with RestClient {
  Future<NetworkResponse> signin(String username, String password) async {
    Map<String, String> params = {
      "usernameOrEmail": username,
      "password": password
    };
    return await getAsync(API.signin, null);
  }
}
