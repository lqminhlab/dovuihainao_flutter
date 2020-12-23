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
        onViewModelReady: (viewModel) async {
          viewModel.init(context);
        },
        builder: (context, viewModel, child) {
          return _buildBody(context);
        });
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.bgStart), fit: BoxFit.cover)),
        ),
        SafeArea(
            child: Center(
          child: Container(
            width: double.maxFinite,
            padding:
                const EdgeInsets.only(top: 15, bottom: 35, left: 15, right: 15),
            child: Image.asset(
              AppImages.imgBanner,
              fit: BoxFit.contain,
            ),
          ),
        )),
      ],
    );
  }
}
