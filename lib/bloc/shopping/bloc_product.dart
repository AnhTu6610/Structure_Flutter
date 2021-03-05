import 'dart:async';
import 'dart:convert';

import 'package:structure_example/bloc/base_bloc/base_bloc.dart';
import 'package:structure_example/data_source/local_data/preference_name.dart';
import 'package:structure_example/data_source/local_data/preference_provider.dart';
import 'package:structure_example/data_source/network_data/product_repository.dart';
import 'package:structure_example/models/response_model/list_product_res.dart';
import 'package:structure_example/models/response_model/product_category_res.dart';
import 'package:structure_example/models/response_model/product_detail_res.dart';

class BlocProduct extends BaseBloc {
  static bool firstRefeshCategory = true;
  static bool firstRefeshProduct = true;
  static bool firstRefeshHLProduct = true;
  ProductRepository _productRepository = new ProductRepository();

  List<Product> _listProduct = [];
  StreamController<List<Product>> _listProductController = new StreamController<List<Product>>.broadcast();
  Stream<List<Product>> get productsStream => _listProductController.stream;
  Sink<List<Product>> get productsSink => _listProductController.sink;

  StreamController<List<Product>> _listHLProductController = new StreamController<List<Product>>.broadcast();
  Stream<List<Product>> get hlProductsStream => _listHLProductController.stream;
  Sink<List<Product>> get hlProductsSink => _listHLProductController.sink;

  StreamController<List<CategoryProduct>> _categoryController = new StreamController<List<CategoryProduct>>.broadcast();
  Stream<List<CategoryProduct>> get categoryStream => _categoryController.stream;
  Sink<List<CategoryProduct>> get categorySink => _categoryController.sink;

  int totalPage = 1;
  List<CategoryProduct> listCat = [];
  Future getListCategory({bool refresh}) async {
    if (refresh ?? false == true || BlocProduct.firstRefeshCategory == true) {
      BlocProduct.firstRefeshCategory = false;
      await PreferenceProvider.setString(PreferenceNames.CATEGORY, null);
    }
    try {
      showLoading();
      var cacheRes = await PreferenceProvider.getString(PreferenceNames.CATEGORY, def: null);
      if (cacheRes == null) {
        var result = await _productRepository.getCategory();
        if (result.isSuccess) {
          CategoryProductRes cats = CategoryProductRes.fromJson(result.body);
          listCat = cats.data;
          categorySink.add(cats.data);
          await PreferenceProvider.setString(PreferenceNames.CATEGORY, jsonEncode(result.body));
          hideLoading();
        } else
          showError(result.message);
      } else {
        CategoryProductRes dataCache = CategoryProductRes.fromJson(jsonDecode(cacheRes));
        listCat = dataCache.data;
        categorySink.add(dataCache.data);
        hideLoading();
      }
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
  }

  Future getListProduct(int limit, int page, {bool refresh}) async {
    if (refresh ?? false == true || BlocProduct.firstRefeshProduct == true) {
      BlocProduct.firstRefeshProduct = false;
      await PreferenceProvider.setString(PreferenceNames.PRODUCT, null);
    }
    try {
      showLoading();
      var cacheRes = await PreferenceProvider.getString(PreferenceNames.PRODUCT, def: null);
      if (cacheRes == null) {
        var result = await _productRepository.getListProduct(limit.toString(), page.toString());
        if (result.isSuccess) {
          ListProductRes listProduct = ListProductRes.fromJson(result.body);
          productsSink.add(listProduct.data.products);
          await PreferenceProvider.setString(PreferenceNames.PRODUCT, jsonEncode(result.body));
          hideLoading();
        } else
          showError(result.message);
      } else {
        ListProductRes dataCache = ListProductRes.fromJson(jsonDecode(cacheRes));
        this._listProduct = dataCache.data.products;
        productsSink.add(dataCache.data.products);
        hideLoading();
      }
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
  }

  Future getListHighlightProduct(int limit, int page, {bool refresh}) async {
    if (refresh ?? false == true || BlocProduct.firstRefeshHLProduct == true) {
      BlocProduct.firstRefeshHLProduct = false;
      await PreferenceProvider.setString(PreferenceNames.HL_PRODUCT, null);
    }
    try {
      showLoading();
      var cacheRes = await PreferenceProvider.getString(PreferenceNames.HL_PRODUCT, def: null);
      if (cacheRes == null) {
        var result = await _productRepository.getListHighProduct(limit.toString(), page.toString());
        if (result.isSuccess) {
          ListProductRes listProduct = ListProductRes.fromJson(result.body);
          hlProductsSink.add(listProduct.data.products);
          await PreferenceProvider.setString(PreferenceNames.HL_PRODUCT, jsonEncode(result.body));
          hideLoading();
        } else
          showError(result.message);
      } else {
        ListProductRes dataCache = ListProductRes.fromJson(jsonDecode(cacheRes));
        hlProductsSink.add(dataCache.data.products);
        hideLoading();
      }
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
  }

  Future<DataProductDetailRes> getProductDetail(String idProduct) async {
    try {
      showLoading();
      var result = await _productRepository.getProductDetail(idProduct);
      if (result.isSuccess) {
        ProductDetailRes productDetailRes = ProductDetailRes.fromJson(result.body);
        hideLoading();
        return productDetailRes.data;
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    return null;
  }

  Future getListProductByCategory(int limit, int page, String idCat) async {
    try {
      showLoading();
      var result = await _productRepository.getListProductByCat(limit.toString(), page.toString(), idCat);
      if (result.isSuccess) {
        ListProductRes listProduct = ListProductRes.fromJson(result.body);
        if (page == 1) {
          this._listProduct = listProduct.data.products;
          totalPage = listProduct.data.totalResult;
          productsSink.add(listProduct.data.products);
        } else if (listProduct.data.products.length > 0) {
          totalPage = listProduct.data.totalResult ~/ 10 + 1;
          this._listProduct.addAll(listProduct.data.products);
          productsSink.add(this._listProduct);
        }
        hideLoading();
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
  }

  Future searchProduct(int limit, int page, String idCat, String search) async {
    try {
      showLoading();
      var result = await _productRepository.searchProduct(limit.toString(), page.toString(), idCat, search);
      if (result.isSuccess) {
        ListProductRes listProduct = ListProductRes.fromJson(result.body);

        this._listProduct = listProduct.data.products;
        productsSink.add(this._listProduct);
        hideLoading();
        if (listProduct.data.products.length == 0) return false;
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    return true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _listProductController.close();
    _listHLProductController.close();
    _categoryController.close();
    _listProduct.clear();
  }
}
