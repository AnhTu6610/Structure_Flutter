import 'package:structure_example/data_source/network_data/config/apisubdomain.dart';
import 'package:structure_example/data_source/network_data/config/network_response.dart';
import 'package:structure_example/data_source/network_data/config/restclient.dart';
import 'package:structure_example/data_source/network_data/interface/event_api_provider.dart';
import 'package:structure_example/data_source/network_data/interface/product_api_provider.dart';
import 'package:structure_example/data_source/network_data/interface/news_api_provider.dart';

class EventRepository with RestClient, EventApiProvider {
  // final String _STATUS = "cam-nang";

  // @override
  // Future<NetworkResponse> getListCategory() async {
  //   Map<String, String> query = {"type": this._TYPE};
  //   await getAsyncWithToken(API.categorNews, query: query);
  // }

  @override
  Future<NetworkResponse> getListEvent(String limit, String page, String status) async {
    Map<String, String> query = {"limit": limit, "page": page, "filter_status": status};
    return await getAsyncWithToken(API.listEvent, query: query);
  }

  @override
  Future<NetworkResponse> getEventDetail(String idEvent) async {
    Map<String, String> query = {"id": idEvent};
    return await getAsyncWithToken(API.eventDetail, query: query);
  }

  @override
  Future<NetworkResponse> cancelEven(String idEvent) async {
    Map<String, String> query = {"id": idEvent};
    return await getAsyncWithToken(API.cancelEvent, query: query);
  }

  @override
  Future<NetworkResponse> joinEvent(String idEvent) async {
    Map<String, String> query = {"id": idEvent};
    return await getAsyncWithToken(API.joinEvent, query: query);
  }
}
