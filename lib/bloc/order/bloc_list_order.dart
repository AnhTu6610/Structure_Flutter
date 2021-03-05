import 'dart:async';

import 'package:structure_example/bloc/base_bloc/base_bloc.dart';
import 'package:structure_example/data_source/network_data/order_repository.dart';
import 'package:structure_example/models/response_model/list_order_res.dart';

class BlocListOrder extends BaseBloc {
  OrderRepository _orderRepository = new OrderRepository();
  StreamController<List<OrderRes>> _listOrderController = new StreamController<List<OrderRes>>();
  Stream<List<OrderRes>> get ordersStream => _listOrderController.stream;
  Sink<List<OrderRes>> get ordersSink => _listOrderController.sink;

  int totalPage = 1;
  List<OrderRes> listOrder = [];
  Future getListOrder(int limit, int page, String status) async {
    try {
      showLoading();
      var result = await _orderRepository.getListOrder(limit.toString(), page.toString(), status);
      if (result.isSuccess) {
        ListOrderRes listOrder = ListOrderRes.fromJson(result.body);
        if (page == 1) {
          this.listOrder = listOrder.data.data;
          totalPage = listOrder.data.totalResult;
          ordersSink.add(listOrder.data.data);
        } else if (listOrder.data.data.length > 0) {
          totalPage = listOrder.data.totalResult ~/ 10 + 1;
          this.listOrder.addAll(listOrder.data.data);
          ordersSink.add(this.listOrder);
        }

        hideLoading();
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
  }
}
