import 'dart:async';
import 'package:structure_example/data_source/network_data/network_response.dart';
import 'package:structure_example/data_source/network_data/user_repository.dart';
import 'package:structure_example/main.dart';
import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/widgets/common_dialog.dart';

abstract class BaseBloc {
  UserRepository userRepository = new UserRepository();
  StreamController<bool> _loaddingController = StreamController<bool>();
  Stream<bool> get loaddingStream => _loaddingController.stream;
  Sink<bool> get loaddingSink => _loaddingController.sink;

  void showLoading() {
    loaddingSink.add(true);
  }

  void hideLoading() {
    loaddingSink.add(false);
  }

  void dispose() {
    _loaddingController.close();
  }

  void showError(String textError) {
    loaddingSink.add(false);

    showOkDialog(MyApp.navigatorKey.currentContext, textError, () {
      MyApp.navigatorKey.currentState.pop();
    }, true, ColorsData.blue_1, "OK");
  }

  void showErrorNetworkAction(NetworkException networkException,
      [Function ontapOk]) {
    switch (networkException) {
      case NetworkException.NoInternet:
        _dialogError("Không có internet", ontapOk);
        break;
      case NetworkException.NoServiceFound:
        _dialogError("Không tìm thấy dịch vụ", ontapOk);
        break;
      case NetworkException.InvalidFormat:
        _dialogError("Định dạng không hợp lệ", ontapOk);
        break;
      case NetworkException.Unknown:
        _dialogError("Lỗi không xác định", ontapOk);
        break;
      case NetworkException.TokenDie:
        _dialogError("Token hết hạn", ontapOk);
        break;
      default:
        _dialogError(networkException.toString(), ontapOk);
    }
    loaddingSink.add(false);
  }

  void showErrorAction(String textError, Function ontapOk) {
    loaddingSink.add(false);

    showOkDialog(MyApp.navigatorKey.currentContext, textError, ontapOk, true,
        ColorsData.blue_1, "OK");
  }

  //---
  _dialogError(String textError, Function ontapOk) {
    showOkDialog(MyApp.navigatorKey.currentContext, textError, () {
      MyApp.navigatorKey.currentState.pop();
      if (ontapOk != null) ontapOk();
    }, true, ColorsData.blue_1, "OK");
  }
}
