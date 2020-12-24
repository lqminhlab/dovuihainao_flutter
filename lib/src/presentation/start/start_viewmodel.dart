import 'package:dovuihainao_flutter/src/presentation/presentation.dart';
import 'package:dovuihainao_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../resource/resource.dart';

class StartViewModel extends BaseViewModel {
  final OtherRepository repository;

  StartViewModel({@required this.repository});

  init() async {}

  void goToGame()  {
    AppSound.play("play.wav");
    Navigator.pushNamed(context, Routers.home);
  }

  void goToMoreApp() {
    Navigator.pushNamed(context, Routers.moreApp);
  }
}
