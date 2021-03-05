import 'package:structure_example/data_source/network_data/config/apisubdomain.dart';
import 'package:structure_example/data_source/network_data/config/network_response.dart';
import 'package:structure_example/data_source/network_data/config/restclient.dart';
import 'package:structure_example/data_source/network_data/interface/notification_api_provider.dart';
import 'package:structure_example/data_source/network_data/interface/product_api_provider.dart';
import 'package:structure_example/data_source/network_data/interface/news_api_provider.dart';

class NotificationRepository with RestClient, NotificationApiProvider {
  final String _TYPE = "cam-nang";

  @override
  Future<NetworkResponse> getListNotification(
    String limit,
    String page,
  ) async {
    Map<String, String> query = {
      "limit": limit,
      "page": page,
    };
    return await getAsyncWithToken(API.listNotification, query: query);
  }
}
