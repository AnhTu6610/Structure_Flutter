import 'package:structure_example/data_source/network_data/config/network_response.dart';

abstract class NotificationApiProvider {
  Future<NetworkResponse> getListNotification(String limit, String page);
}
