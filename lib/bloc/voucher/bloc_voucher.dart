import 'dart:async';

import 'package:structure_example/bloc/base_bloc/base_bloc.dart';
import 'package:structure_example/data_source/network_data/voucher_repository.dart';
import 'package:structure_example/models/response_model/list_voucher_res.dart';

class BlocVoucher extends BaseBloc {
  VoucherRepository _voucherRepository = new VoucherRepository();
  StreamController<List<VoucherRes>> _listVoucherController = new StreamController<List<VoucherRes>>();
  Stream<List<VoucherRes>> get vouchersStream => _listVoucherController.stream;
  Sink<List<VoucherRes>> get vouchersSink => _listVoucherController.sink;

  int totalPage = 1;
  List<VoucherRes> listVoucher = [];
  Future getListVoucher(int limit, int page) async {
    try {
      showLoading();
      var result = await _voucherRepository.getListVoucher(limit.toString(), page.toString());
      if (result.isSuccess) {
        ListVoucherRes listVoucher = ListVoucherRes.fromJson(result.body);
        if (page == 1) {
          this.listVoucher = listVoucher.data.data;
          totalPage = listVoucher.data.totalResults;
          vouchersSink.add(listVoucher.data.data);
        } else if (listVoucher.data.data.isNotEmpty) {
          totalPage = listVoucher.data.totalResults ~/ 10 + 1;
          this.listVoucher.addAll(listVoucher.data.data);
          vouchersSink.add(this.listVoucher);
        }

        hideLoading();
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
  }
}
