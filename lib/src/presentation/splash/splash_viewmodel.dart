import 'package:flutter/material.dart';
import '../../resource/resource.dart';
import '../base/base.dart';

class SplashViewModel extends BaseViewModel{

  final OtherRepository repository;

  SplashViewModel({@required this.repository});

  init()async{
    final NetworkState<OtherApplication> rs = await repository.getMoreApps();
    final otherApp = rs.data;
    print("Other apps: ${otherApp?.toJson() ?? "Nullllll!"}");
  }
}