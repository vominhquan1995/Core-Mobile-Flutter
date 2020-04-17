import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/widgets/search/model/search_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String KEY_SEARCH = 'history_seach';

class SearchService {
  SearchService();
  Future<List<String>> getHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> history = prefs.getStringList(KEY_SEARCH);
      history = history == null ? [] : history.take(10).toList();
      return history;
    } catch (e) {
      return [];
    }
  }

  Future<bool> updateHistory(String item) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> list = await getHistory();
      list.insert(0, item);
      await prefs.setStringList(KEY_SEARCH, list);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(KEY_SEARCH, []);
      return true;
    } catch (e) {
      return false;
    }
  }
}
