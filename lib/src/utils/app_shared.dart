import 'dart:async';

import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppShared {

  AppShared._();

  static final prefs = RxSharedPreferences(SharedPreferences.getInstance());

  static const String keyAccessToken = "keyViSafeAccessToken";


  static Future<bool> setAccessToken(String token) =>
      prefs.setString(keyAccessToken, token);

  static Future<String> getAccessToken() => prefs.getString(keyAccessToken);
}
