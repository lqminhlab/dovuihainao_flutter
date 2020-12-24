import 'dart:io';

import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:dovuihainao_flutter/src/presentation/presentation.dart';
import 'package:dovuihainao_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:in_app_review/in_app_review.dart';

class StartViewModel extends BaseViewModel {

  init() async {}

  void shareURL() {
    Share.share(
        Platform.isIOS ? AppValues.URL_SHARE_IOS : AppValues.URL_SHARE_ANDROID);
  }

  void rateApp() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  void goToGame() {
    AppSound.play("play.wav");
    Navigator.pushNamed(context, Routers.home);
  }

  void goToMoreApp() {
    Navigator.pushNamed(context, Routers.moreApp);
  }
}
