import 'package:structure_example/data_source/network_data/config/network_response.dart';

abstract class NewsApiProvider {
  Future<NetworkResponse> getListHandBookCategory();
  Future<NetworkResponse> getListNews(String limit, String page);
  Future<NetworkResponse> getListNewsHighlight(String limit, String page);
  Future<NetworkResponse> getNewsDetail(String idProduct);
  Future<NetworkResponse> getListNewsCategory();
  Future<NetworkResponse> getListHandBook(String limit, String page);
  Future<NetworkResponse> getListHandBookByCategory(String limit, String page, String category);
  Future<NetworkResponse> getHandBookDetail(String idProduct);
  Future<NetworkResponse> searchHandbook(String limit, String page, String category, String textSearch);
}
