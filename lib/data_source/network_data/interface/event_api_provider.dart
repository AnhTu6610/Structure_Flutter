import 'package:structure_example/data_source/network_data/config/network_response.dart';

abstract class EventApiProvider {
  // Future<NetworkResponse> getListCategory();
  Future<NetworkResponse> getListEvent(String limit, String page, String status);
  Future<NetworkResponse> getEventDetail(String idEvent);
  Future<NetworkResponse> joinEvent(String idEvent);
  Future<NetworkResponse> cancelEven(String idEvent);
}
