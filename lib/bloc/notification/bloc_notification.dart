import 'dart:async';

import 'package:structure_example/bloc/base_bloc/base_bloc.dart';
import 'package:structure_example/data_source/network_data/notification_repository.dart';
import 'package:structure_example/models/response_model/list_notification_res.dart';

class BlocNotification extends BaseBloc {
  NotificationRepository _notificationRepository = new NotificationRepository();
  StreamController<List<NotificationRes>> _listNotificationController = new StreamController<List<NotificationRes>>();
  Stream<List<NotificationRes>> get notificationsStream => _listNotificationController.stream;
  Sink<List<NotificationRes>> get notificationsSink => _listNotificationController.sink;

  Future getListProduct(int limit, int page) async {
    try {
      showLoading();
      var result = await _notificationRepository.getListNotification(limit.toString(), page.toString());
      if (result.isSuccess) {
        ListNotificationRes listProduct = ListNotificationRes.fromJson(result.body);

        notificationsSink.add(listProduct.data.data);
        hideLoading();
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
  }
}
