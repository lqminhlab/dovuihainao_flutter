import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import '../../configs/configs.dart';
import '../../utils/utils.dart';
import '../resource.dart';

class OtherRepository{

  ///http://relax365.net/hsmoreapp?os=
  Future<NetworkState<OtherApplication>> getMoreApps() async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      String api = AppEndpoint.MORE_APPS;
      Map<String, dynamic> params = {
        "os" : Platform.isAndroid ? "android" : "ios"
      };
      Response response = await AppClients().get(api, queryParameters: params);
      return NetworkState(
        status: AppEndpoint.SUCCESS,
        data: OtherApplication.fromJson(jsonDecode(response.data)),
      );
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  ///http://relax365.net/hsdovuihainao
  Future<NetworkState<QuestionModel>> getQuestionByIndex({int index = 0}) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      String api = AppEndpoint.MORE_APPS;
      Map<String, dynamic> params = {
        "os" : Platform.isAndroid ? "android" : "ios"
      };
      Response response = await AppClients().get(api, queryParameters: params);
      return NetworkState(
        status: AppEndpoint.SUCCESS,
        data: QuestionModel.fromJson(jsonDecode(response.data)),
      );
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }
}