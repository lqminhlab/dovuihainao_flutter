import 'dart:async';
import 'dart:convert';

import 'package:dovuihainao_flutter/src/resource/model/process.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppShared {
  AppShared._();

  static final prefs = RxSharedPreferences(SharedPreferences.getInstance());

  static const String keyAccessToken = "keyAccessToken";
  static const String keyProcess = "keyProcess";

  static Future<bool> setAccessToken(String token) =>
      prefs.setString(keyAccessToken, token);

  static Future<String> getAccessToken() => prefs.getString(keyAccessToken);

  static Stream<ProcessModel> watchProcess() {
    return prefs.getStringStream(keyProcess).transform(
        StreamTransformer.fromHandlers(
            handleData: (data, sink) => (data == null || data.length == 0)
                ? sink.add(null)
                : sink.add(ProcessModel.fromJson(jsonDecode(data)))));
  }

  static Future<bool> setProcess(ProcessModel data) async {
    ProcessModel process = await getProcess();
    String dataJson;
    if (process != null)
      dataJson = data == null
          ? ""
          : jsonEncode(ProcessModel(
              questions: data.questions ?? process.questions,
              score: data.score ?? process.score,
              offset: data.offset ?? process.offset,
              heart: data.heart ?? process.heart));
    else
      dataJson = data == null ? "" : jsonEncode(data);
    return prefs.setString(keyProcess, dataJson);
  }

  static Future<ProcessModel> getProcess() async {
    String dataString = await prefs.getString(keyProcess);
    if (dataString != null && dataString.length != 0)
      return ProcessModel.fromJson(jsonDecode(dataString));
    else
      return null;
  }
}
