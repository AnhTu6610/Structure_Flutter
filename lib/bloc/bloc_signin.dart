import 'dart:async';
import 'dart:convert';

import 'package:structure_example/bloc/base_bloc/base_bloc.dart';
import 'package:structure_example/data_source/local_data/preference_provider.dart';
import 'package:structure_example/data_source/local_data/share_preference_name.dart';
import 'package:structure_example/data_source/network_data/exception_repository.dart';
import 'package:structure_example/main.dart';
import 'package:structure_example/models/response_model/login_res.dart';
import 'package:structure_example/utils/debug_print.dart';

class BlocSignin extends BaseBloc {
  Future signin(String username, String password) async {
    try {
      showLoading();
      var result = await userRepository.signin(username, password);
      if (result.isSuccess) {
        LoginRes loginRes = LoginRes.fromJson(jsonDecode(result.body));
        hideLoading();
        return true;
      } else {
        showErrorNetworkAction(result.networkEXC);
      }
    } catch (e) {
      showErrorAction("Vui lòng thử lại", () {
        MyApp.navigatorKey.currentState.pop();
        signin(username, password);
      });
      debugPrint(e, "BLOC ERROR");
    }
    return false;
  }

  @override
  dispose() {
    super.dispose();
  }
}
