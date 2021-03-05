import 'package:structure_example/data_source/network_data/config/apisubdomain.dart';
import 'package:structure_example/data_source/network_data/config/network_response.dart';
import 'package:structure_example/data_source/network_data/config/restclient.dart';
import 'package:structure_example/data_source/network_data/interface/product_api_provider.dart';
import 'package:structure_example/models/response_model/product_detail_res.dart';

class ProductRepository with RestClient, ProductApiProvider {
  @override
  Future<NetworkResponse> getListCategory() async => await getAsyncWithToken(API.categoryProduct);

  @override
  Future<NetworkResponse> getListProduct(String limit, String page) async {
    Map<String, String> query = {"limit": limit, "page": page};
    return await getAsyncWithToken(API.listProduct, query: query);
  }

  @override
  Future<NetworkResponse> getListProductByCat(String limit, String page, String idCat) async {
    Map<String, String> query = {"limit": limit, "page": page, "category": idCat != null ? '["$idCat"]' : ""};
    return await getAsyncWithToken(API.listProduct, query: query);
  }

  @override
  Future<NetworkResponse> searchProduct(String limit, String page, String idCat, String textSerach) async {
    Map<String, String> query = {"limit": limit, "page": page, "category": idCat != null ? '["$idCat"]' : "", "search": textSerach};
    return await getAsyncWithToken(API.listProduct, query: query);
  }

  @override
  Future<NetworkResponse> getProductDetail(String idProduct) async {
    Map<String, String> query = {"id": idProduct};
    return await getAsyncWithToken(API.productDetail, query: query);
  }

  @override
  Future<NetworkResponse> getCategory() async {
    return await getAsyncWithToken(API.categoryProduct);
  }

  @override
  Future<NetworkResponse> order(String receiver, String phone, String address, String note, String typePayment, String discount, List<Product> listProduct) async {
    Map<String, dynamic> body = {
      "receiver": receiver,
      "phone_receiver": phone,
      "address": address,
      "note": note,
      "type_payment": typePayment,
      "discount": discount,
      "product_array": [],
    };
    List<Map<String, dynamic>> litsMapProduct = [];
    listProduct.forEach((product) {
      litsMapProduct.add({"product_id": product.sId, "amount": product.amount});
    });

    body["product_array"] = litsMapProduct;
    return await postAsyncWithToken(API.order, body: body);
  }

  @override
  Future<NetworkResponse> getListHighProduct(String limit, String page) async {
    Map<String, String> query = {"limit": limit, "page": page};
    return await getAsyncWithToken(API.listHighlightProduct, query: query);
  }

  @override
  Future<NetworkResponse> checkVoucher(String code, String totalMoney) async {
    Map<String, String> query = {"code": code, "total_money": totalMoney};
    return await getAsyncWithToken(API.checkVoucher, query: query);
  }
}
