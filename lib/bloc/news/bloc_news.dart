import 'dart:async';
import 'dart:convert';

import 'package:structure_example/bloc/base_bloc/base_bloc.dart';
import 'package:structure_example/data_source/local_data/preference_name.dart';
import 'package:structure_example/data_source/local_data/preference_provider.dart';
import 'package:structure_example/data_source/network_data/news_repository.dart';
import 'package:structure_example/models/response_model/list_news_hightlight_res.dart';
import 'package:structure_example/models/response_model/list_news_res.dart';
import 'package:structure_example/models/response_model/news_detail_res.dart';

class BlocNews extends BaseBloc {
  static bool firstRefeshNews = true;
  static bool firstRefeshHLNews = true;
  NewsRepository _newsRepository = new NewsRepository();
  StreamController<List<NewsRes>> _listNewsController = new StreamController<List<NewsRes>>.broadcast();
  Stream<List<NewsRes>> get newssStream => _listNewsController.stream;
  Sink<List<NewsRes>> get newsSink => _listNewsController.sink;

  StreamController<List<NewsHightLightRes>> _listNewsHighLightController = new StreamController<List<NewsHightLightRes>>();
  Stream<List<NewsHightLightRes>> get newsHighlightStream => _listNewsHighLightController.stream;
  Sink<List<NewsHightLightRes>> get newsHightlightSink => _listNewsHighLightController.sink;

  Future getListNewsHightLight(int limit, int page, {bool refresh}) async {
    if (refresh ?? false == true || BlocNews.firstRefeshHLNews == true) {
      BlocNews.firstRefeshHLNews = false;
      await PreferenceProvider.setString(PreferenceNames.NEWS_HIGHLIGHT, null);
    }
    try {
      showLoading();
      var cacheRes = await PreferenceProvider.getString(PreferenceNames.NEWS_HIGHLIGHT, def: null);
      if (cacheRes == null) {
        var result = await _newsRepository.getListNewsHighlight(limit.toString(), page.toString());
        if (result.isSuccess) {
          ListNewsHightLightRes listNewsHightLightRes = ListNewsHightLightRes.fromJson(result.body);
          newsHightlightSink.add(listNewsHightLightRes.data.data);
          await PreferenceProvider.setString(PreferenceNames.NEWS_HIGHLIGHT, jsonEncode(result.body));
          hideLoading();
        } else
          showError(result.message);
      } else {
        ListNewsHightLightRes dataCache = ListNewsHightLightRes.fromJson(jsonDecode(cacheRes));
        newsHightlightSink.add(dataCache.data.data);
        hideLoading();
      }
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
  }

  Future getListNews(int limit, int page, {bool refresh}) async {
    if (refresh ?? false == true || BlocNews.firstRefeshNews == true) {
      BlocNews.firstRefeshNews = false;
      await PreferenceProvider.setString(PreferenceNames.NEWS, null);
    }
    try {
      showLoading();
      var cacheRes = await PreferenceProvider.getString(PreferenceNames.NEWS, def: null);
      if (cacheRes == null) {
        var result = await _newsRepository.getListNews(limit.toString(), page.toString());
        if (result.isSuccess) {
          ListNewsRes listProduct = ListNewsRes.fromJson(result.body);
          newsSink.add(listProduct.data.listNews);
          await PreferenceProvider.setString(PreferenceNames.NEWS, jsonEncode(result.body));
          hideLoading();
        } else
          showError(result.message);
      } else {
        ListNewsRes dataCache = ListNewsRes.fromJson(jsonDecode(cacheRes));
        newsSink.add(dataCache.data.listNews);
        hideLoading();
      }
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
  }

  Future<NewsDetail> getNewsDetail(String idProduct) async {
    try {
      showLoading();
      var result = await _newsRepository.getNewsDetail(idProduct);
      if (result.isSuccess) {
        NewsDetailRes newsDetailRes = NewsDetailRes.fromJson(result.body);

        hideLoading();
        return newsDetailRes.data;
      } else
        showError(result.message);
    } catch (e) {
      showError("Vui lòng thử lại!", exception: e);
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _listNewsController.close();
    _listNewsHighLightController.close();
  }
}
