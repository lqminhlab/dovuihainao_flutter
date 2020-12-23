import 'package:flutter/material.dart';
import '../../resource/resource.dart';
import '../base/base.dart';

class HomeViewModel extends BaseViewModel{

  final OtherRepository repository;

  HomeViewModel({@required this.repository});

  init()async{
    final NetworkState<OtherApplication> rs = await repository.getMoreApps();
    final otherApp = rs.data;
    print("Other apps: ${otherApp?.toJson() ?? "Nullllll!"}");
  }
}