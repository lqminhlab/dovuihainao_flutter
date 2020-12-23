import 'package:dovuihainao_flutter/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import '../../resource/resource.dart';

class StartViewModel extends BaseViewModel {
  final OtherRepository repository;

  StartViewModel({@required this.repository});

  init() async {}

  void goToGame() async {
    Navigator.pushNamed(context, Routers.home);
  }
}
