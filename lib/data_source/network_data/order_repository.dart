import 'package:structure_example/data_source/network_data/config/apisubdomain.dart';
import 'package:structure_example/data_source/network_data/config/network_response.dart';
import 'package:structure_example/data_source/network_data/config/restclient.dart';
import 'package:structure_example/data_source/network_data/interface/notification_api_provider.dart';
import 'package:structure_example/data_source/network_data/interface/order_api_provider.dart';
import 'package:structure_example/data_source/network_data/interface/product_api_provider.dart';
import 'package:structure_example/data_source/network_data/interface/news_api_provider.dart';

class OrderRepository with RestClient, OrderApiProvider {
  final String _TYPE = "cam-nang";

  @override
  Future<NetworkResponse> getListOrder(String limit, String page, String status) async {
    Map<String, String> query = status != null
        ? {
            "limit": limit,
            "page": page,
            "status": status,
          }
        : {
            "limit": limit,
            "page": page,
          };
    return await getAsyncWithToken(API.listOrder, query: query);
  }
}
