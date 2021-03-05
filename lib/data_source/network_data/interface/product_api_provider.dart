import 'package:structure_example/data_source/network_data/config/network_response.dart';
import 'package:structure_example/models/response_model/product_detail_res.dart';

abstract class ProductApiProvider {
  Future<NetworkResponse> getListCategory();
  Future<NetworkResponse> getListProduct(String limit, String page);
  Future<NetworkResponse> getListProductByCat(String limit, String page, String idCat);
  Future<NetworkResponse> searchProduct(String limit, String page, String idCat, String textSerach);
  Future<NetworkResponse> getListHighProduct(String limit, String page);
  Future<NetworkResponse> getProductDetail(String idProduct);
  Future<NetworkResponse> getCategory();
  Future<NetworkResponse> order(String receiver, String phone, String address, String note, String typePayment, String discount, List<Product> listProduct);
  Future<NetworkResponse> checkVoucher(String code, String totalMoney);
}
