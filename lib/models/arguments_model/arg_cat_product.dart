import 'package:structure_example/models/response_model/product_category_res.dart';

class ArgCatProduct {
  String idCat;
  List<CategoryProduct> listCat;
  bool isSearch;
  String textSearch;
  ArgCatProduct({this.idCat, this.listCat, this.isSearch, this.textSearch});
}
