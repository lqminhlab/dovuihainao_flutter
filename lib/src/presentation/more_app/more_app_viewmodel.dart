import 'package:flutter/material.dart';

import '../../resource/resource.dart';
import '../presentation.dart';

class MoreAppViewModel extends BaseViewModel {
  final OtherRepository repository;

  MoreAppViewModel({@required this.repository});

  Future<List<Apps>> getMoreApps() async {
    final NetworkState<OtherApplication> rs = await repository.getMoreApps();
    return rs?.data?.apps ?? [];
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 1));
    notifyListeners();
  }
}
