import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:dovuihainao_flutter/src/resource/resource.dart';
import 'package:dovuihainao_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation.dart';

class MoreAppScreen extends StatelessWidget {
  static const double HEIGHT_APP_BAR = 120;
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
    return Expanded(child: FutureBuilder<List<Apps>>(
      builder: (context, snapshot) {
        return ListView.builder(itemBuilder: (context, index) => WidgetApp());
      },
    ));
  }

  Widget _buildAppBar(BuildContext context) {
    double size = 40;
    return Container(
      height: HEIGHT_APP_BAR,
      width: double.maxFinite,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.bgAppBarMoreApp))),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          Center(child: Image.asset(AppImages.imgMoreApp)),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
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
