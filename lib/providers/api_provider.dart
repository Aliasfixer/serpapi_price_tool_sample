import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider extends ChangeNotifier{

  late String? _apikey;

  String? get api => _apikey;

  ApiProvider() {
    loadApiKey();
  }

  Future<void> loadApiKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _apikey = prefs.getString('apikey');
    notifyListeners();
  }

  Future<void> deleteApiKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('apikey');
    _apikey = null;
    notifyListeners();
  }

  Future<void> setApiKey(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('apikey', key);
    _apikey = key;
    notifyListeners();
  }

}