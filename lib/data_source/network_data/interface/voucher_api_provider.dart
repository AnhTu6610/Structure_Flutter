import 'package:structure_example/data_source/network_data/config/network_response.dart';

abstract class VoucherApiProvider {
  Future<NetworkResponse> getListVoucher(String limit, String page);
}
