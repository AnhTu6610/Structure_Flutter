import 'dart:async';
import 'dart:convert';

import 'package:structure_example/bloc/base_bloc/base_bloc.dart';
import 'package:structure_example/data_source/local_data/preference_name.dart';
import 'package:structure_example/data_source/local_data/preference_provider.dart';
import 'package:structure_example/data_source/network_data/contact_repository.dart';
import 'package:structure_example/models/response_model/list_contact_res.dart';

class BlocContact extends BaseBloc {
  ContactRepository _contactRepository = new ContactRepository();
  StreamController<List<ContactRes>> _listContactController = new StreamController<List<ContactRes>>();
  Stream<List<ContactRes>> get contactsStream => _listContactController.stream;
  Sink<List<ContactRes>> get contactsSink => _listContactController.sink;

  Future getListContact(int limit, int page, {bool refresh}) async {
    if (refresh ?? false == true) await PreferenceProvider.setString(PreferenceNames.CONTACT, null);
    try {
      showLoading();
      var cacheRes = await PreferenceProvider.getString(PreferenceNames.CONTACT, def: null);
      if (cacheRes == null) {
        var result = await _contactRepository.getListContact(limit.toString(), page.toString());
        if (result.isSuccess) {
          ListContactRes listContact = ListContactRes.fromJson(result.body);
          contactsSink.add(listContact.data);
          await PreferenceProvider.setString(PreferenceNames.CONTACT, jsonEncode(result.body));
          hideLoading();
        } else
          showError(result.message);
      } else {
        ListContactRes dataCache = ListContactRes.fromJson(jsonDecode(cacheRes));
        contactsSink.add(dataCache.data);
        hideLoading();
      }
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
  }
}
