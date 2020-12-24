import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:dovuihainao_flutter/src/resource/resource.dart';
import 'package:dovuihainao_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../presentation.dart';

class MoreAppScreen extends StatelessWidget {
  static const double HEIGHT_APP_BAR = 100;
  MoreAppViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<MoreAppViewModel>(
        viewModel: MoreAppViewModel(repository: Provider.of(context)),
        onViewModelReady: (viewModel) async {
          _viewModel = viewModel;
        },
        builder: (context, viewModel, child) {
          return _buildBody(context);
        });
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.bgMoreApp), fit: BoxFit.cover)),
        ),
        SafeArea(
          child: Column(
            children: [_buildAppBar(context), _buildMoreApp()],
          ),
        ),
      ],
    ));
  }

  Widget _buildMoreApp() {
    return Expanded(
        child: FutureBuilder<List<Apps>>(
      future: _viewModel.getMoreApps(),
      builder: (context, snapshot) {
        List<Apps> apps = snapshot.data ?? [];
        if (snapshot.connectionState == ConnectionState.done)
          return RefreshIndicator(
            onRefresh: _viewModel.refresh,
            child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 10, top: 5),
                physics: BouncingScrollPhysics(),
                itemCount: apps.length == 0 ? 1 : apps.length,
                itemBuilder: apps.length == 0
                    ? (context, index) => SizedBox(
                          width: double.maxFinite,
                          height: Get.height,
                        )
                    : (context, index) => WidgetApp(
                          app: apps[index],
                        )),
          );
        return Center(
          child: WidgetCircleProgress(),
        );
      },
    ));
  }

  Widget _buildAppBar(BuildContext context) {
    double size = 40;
    return Container(
      height: HEIGHT_APP_BAR,
      width: double.maxFinite,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.bgAppBarMoreApp), fit: BoxFit.fill)),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          Center(child: Image.asset(AppImages.imgMoreApp, fit: BoxFit.fill)),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10),
            child: WidgetImageButton(
              onTap: () {
                AppSound.play("back.wav");
                Navigator.pop(context);
              },
              width: size,
              height: size,
              pressedImage: Image.asset(AppImages.imgBtnBackPress),
              unpressedImage: Image.asset(AppImages.imgBtnBack),
            ),
          ),
        ],
      ),
    );
  }
}
