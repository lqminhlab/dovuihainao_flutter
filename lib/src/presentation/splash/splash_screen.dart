import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:flutter/material.dart';
import '../base/base.dart';
import 'package:provider/provider.dart';
import 'splash.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<SplashViewModel>(
        viewModel: SplashViewModel(repository: Provider.of(context)),
        onViewModelReady: (viewModel) {
          viewModel.init();
        },
        builder: (context, viewModel, child) {
          return _buildBody(context);
        });
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text(AppLocalizations.of(context).translate("app_name")),
        ),
      ),
    );
  }
}
