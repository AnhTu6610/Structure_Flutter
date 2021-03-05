import 'package:structure_example/data_source/network_data/config/apisubdomain.dart';
import 'package:structure_example/data_source/network_data/config/network_response.dart';
import 'package:structure_example/data_source/network_data/config/restclient.dart';
import 'package:structure_example/data_source/network_data/interface/news_api_provider.dart';

class NewsRepository with RestClient, NewsApiProvider {
  final String _TYPE_HANDBOOK = "cam-nang";
  final String _TYPE_NEWS = "tin-tuc";
  @override
  Future<NetworkResponse> getListNewsCategory() async {
    Map<String, String> query = {"type": this._TYPE_NEWS};
    await getAsyncWithToken(API.categorNews, query: query);
  }

  @override
  Future<NetworkResponse> getListNews(
    String limit,
    String page,
  ) async {
    Map<String, String> query = {"limit": limit, "page": page, "type": this._TYPE_NEWS};
    return await getAsyncWithToken(API.listNews, query: query);
  }

  @override
  Future<NetworkResponse> getNewsDetail(String idProduct) async {
    Map<String, String> query = {"id": idProduct};
    return await getAsyncWithToken(API.newsDetail, query: query);
  }

  @override
  Future<NetworkResponse> getListHandBookCategory() async {
    Map<String, String> query = {"type": this._TYPE_HANDBOOK};
    return await getAsyncWithToken(API.categorNews, query: query);
  }

  @override
  Future<NetworkResponse> getListHandBook(String limit, String page) async {
    Map<String, String> query = {"limit": limit, "page": page, "type": this._TYPE_HANDBOOK};
    return await getAsyncWithToken(API.listNews, query: query);
  }

  @override
  Future<NetworkResponse> getHandBookDetail(String idProduct) async {
    Map<String, String> query = {"id": idProduct};
    return await getAsyncWithToken(API.newsDetail, query: query);
  }

  @override
  Future<NetworkResponse> getListNewsHighlight(String limit, String page) async {
    Map<String, String> query = {"type": this._TYPE_NEWS};
    return await getAsyncWithToken(API.listNewsHighlight, query: query);
  }

  @override
  Future<NetworkResponse> getListHandBookByCategory(String limit, String page, String category) async {
    Map<String, String> query = {"limit": limit, "page": page, "type": this._TYPE_HANDBOOK, "category": category != null ? '["$category"]' : ""};
    return await getAsyncWithToken(API.listNews, query: query);
  }

  @override
  Future<NetworkResponse> searchHandbook(String limit, String page, String category, String textSearch) async {
    Map<String, String> query = {"limit": limit, "page": page, "type": this._TYPE_HANDBOOK, "category": category != null ? '["$category"]' : "", "search": textSearch};
    return await getAsyncWithToken(API.listNews, query: query);
  }
}
