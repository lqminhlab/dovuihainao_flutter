import 'package:flutter/material.dart';

import '../../resource/resource.dart';
import '../presentation.dart';

class MoreAppViewModel extends BaseViewModel {
  final OtherRepository repository;

  MoreAppViewModel({@required this.repository});

  Future<OtherApplication> getMoreApp() async {
    final NetworkState<OtherApplication> rs = await repository.getMoreApps();
    return rs?.data ?? [];
  }
}
