import 'dart:async';

import 'package:flutter/material.dart';
import 'package:structure_example/bloc/base_bloc/base_bloc.dart';
import 'package:structure_example/data_source/local_data/preference_name.dart';
import 'package:structure_example/data_source/local_data/preference_provider.dart';
import 'package:structure_example/data_source/local_data/sqlite_provider.dart';
import 'package:structure_example/data_source/network_data/product_repository.dart';
import 'package:structure_example/models/response_model/product_detail_res.dart';
import 'package:structure_example/utils/log_debug.dart';

class BlocOrder with BaseBloc, ChangeNotifier {
  ProductRepository _productRepository = new ProductRepository();
  SqliteProvider _sqliteProvider = new SqliteProvider();
  StreamController<List<Product>> _streamCartController = StreamController<List<Product>>.broadcast();
  Stream<List<Product>> get listProductCartStream => _streamCartController.stream;
  Sink<List<Product>> get listProductCartSink => _streamCartController.sink;
  List<Product> listProductCart = [];
  String receiver, phone, email, city, district, ward, address, note = "";
  int provisionalMoney, vatMoney, totalMoney = 0;
  int discount = 0, maxBill = 0, minBill = 0;
  String couponType = "";
  String coupon = "";

  _setPay() {
    provisionalMoney = provisionalMoney = totalMoney = 0;
    for (var i = 0; i < listProductCart.length; i++) {
      provisionalMoney += listProductCart[i].price * listProductCart[i].amount;
    }
    vatMoney = (provisionalMoney * 0.1).toInt();
    int discountMoney = 0;
    if (totalMoney > maxBill && totalMoney < minBill) {
      this.couponType = this.coupon = "";
      this.discount = this.maxBill = this.minBill = 0;
    } else
      switch (couponType) {
        case "price":
          discountMoney = this.discount;
          break;
        case "percent":
          discountMoney = provisionalMoney * this.discount ~/ 100;
          break;
        default:
      }
    totalMoney = provisionalMoney + vatMoney - discountMoney;
    if (totalMoney < 0) totalMoney = 0;
    notifyListeners();
  }

  Future resetOrder() async {
    provisionalMoney = provisionalMoney = totalMoney = 0;
    note = "";
    await _sqliteProvider.deleteCart();
    listProductCart = [];
    listProductCartSink.add(listProductCart);
  }

  Future loadListProductCart() async {
    List<Product> result = await _sqliteProvider.getAllProductInCart();
    listProductCart = result;
    listProductCartSink.add(listProductCart);
    _setPay();
    notifyListeners();
  }

  Future addToCart(Product product) async {
    Product oldProduct = await _sqliteProvider.getProductById(product.sId);
    if (oldProduct != null) {
      product = oldProduct..amount = oldProduct.amount + 1;
      await _sqliteProvider.updateProductInCart(product);
    } else {
      await _sqliteProvider.insertProductIToCart(product..amount = 1);
    }
    await loadListProductCart();
  }

  Future increase(Product product) async {
    product.amount++;
    await _sqliteProvider.updateProductInCart(product);
    await loadListProductCart();
  }

  Future reduction(Product product) async {
    if (product.amount == 1) {
      await remove(product);
    } else {
      product.amount--;
      await _sqliteProvider.updateProductInCart(product);
      await loadListProductCart();
    }
  }

  Future remove(Product product) async {
    await _sqliteProvider.deleteProductInCart(product);
    await loadListProductCart();
  }

  Future payment() async {
    try {
      showLoading();
      PreferenceProvider.setString(PreferenceNames.RECEIVER, this.receiver);
      PreferenceProvider.setString(PreferenceNames.PHONE, this.phone);
      PreferenceProvider.setString(PreferenceNames.EMAIL, this.email);
      PreferenceProvider.setString(PreferenceNames.ADDRESS, this.address);
      PreferenceProvider.setString(PreferenceNames.WRAD, this.ward);
      PreferenceProvider.setString(PreferenceNames.DISTRICT, this.district);
      PreferenceProvider.setString(PreferenceNames.CITY, this.city);
      String fullAddress = "${this.address}, ${this.ward}, ${this.district}, ${this.city}";
      var result = await _productRepository.order(receiver, phone, fullAddress, note == "" ? null : note, "cod", coupon == "" ? null : coupon, listProductCart);
      if (result.isSuccess) {
        if (result.body['code'] == 0) {
          hideLoading();
          resetOrder();
          return true;
        }
        showError("Đặt hàng thất bại");
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    return false;
  }

  Future getInfoDelivery() async {
    this.receiver = await PreferenceProvider.getString(PreferenceNames.RECEIVER, def: "");
    this.phone = await PreferenceProvider.getString(PreferenceNames.PHONE, def: "");
    this.email = await PreferenceProvider.getString(PreferenceNames.EMAIL, def: "");
    this.address = await PreferenceProvider.getString(PreferenceNames.ADDRESS, def: "");
    this.ward = await PreferenceProvider.getString(PreferenceNames.WRAD, def: "");
    this.district = await PreferenceProvider.getString(PreferenceNames.DISTRICT, def: "");
    this.city = await PreferenceProvider.getString(PreferenceNames.CITY, def: "");
  }

  Future checkVoucher(String code) async {
    try {
      showLoading();
      var result = await _productRepository.checkVoucher(code, this.provisionalMoney.toString());
      if (result.isSuccess) {
        if (result.body['code'] == 3) {
          showError("Mã giảm giá không hợp lệ");
          return false;
        }
        if (result.body['code'] == 2) {
          showError("Mã giảm không tồn tại");
          return false;
        }
        if (result.body['code'] == 0) {
          this.coupon = code;
          switch (result.body['data']['type']) {
            case "price":
              this.couponType = "price";
              this.discount = result.body['data']['number'];
              this.maxBill = result.body['data']['max_bill'];
              this.minBill = result.body['data']['min_bill'];
              break;
            case "percent":
              this.couponType = "percent";
              this.discount = result.body['data']['number'];
              this.maxBill = result.body['data']['max_bill'];
              this.minBill = result.body['data']['min_bill'];
              break;
            default:
          }
        }
        _setPay();
        hideLoading();
        return true;
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    return false;
  }

  Future removeVoucher() async {
    this.couponType = this.coupon = "";
    this.discount = this.maxBill = this.minBill = 0;
    _setPay();
  }
}
