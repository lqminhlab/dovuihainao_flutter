import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:dovuihainao_flutter/src/resource/model/process.dart';
import 'package:dovuihainao_flutter/src/utils/app_shared.dart';
import 'package:dovuihainao_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import '../base/base.dart';
import 'package:provider/provider.dart';

import '../presentation.dart';

class StartScreen extends StatelessWidget {
  StartViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<StartViewModel>(
        viewModel: StartViewModel(repository: Provider.of(context)),
        onViewModelReady: (viewModel) {
          _viewModel = viewModel..init();
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
                  image: AssetImage(AppImages.bgStart), fit: BoxFit.cover)),
        ),
        SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildRowButton(),
                  _buildLogo(),
                  _buildButtonNavigator()
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildLevel() {
    return StreamBuilder<ProcessModel>(
        stream: AppShared.watchProcess(),
        builder: (context, snapshot) {
          return Text(
            "Cấp độ ${snapshot.data?.score ?? 1}",
            style: AppStyles.DEFAULT_MEDIUM.copyWith(
                fontSize: 26,
                fontFamily: AppStyles.FONT_SUNSHINEY,
                fontWeight: FontWeight.w900),
          );
        });
  }

  Widget _buildButtonNavigator() {
    double width = 150;
    return Column(
      children: [
        _buildLevel(),
        const SizedBox(
          height: 30,
        ),
        WidgetImageButton(
          onTap: _viewModel.goToGame,
          width: width,
          height: width / 3,
          pressedImage: Image.asset(AppImages.imgBtnStartPress),
          unpressedImage: Image.asset(AppImages.imgBtnStart),
        ),
        const SizedBox(
          height: 15,
        ),
        WidgetImageButton(
          onTap: _viewModel.goToGame,
          width: width,
          height: width / 3,
          pressedImage: Image.asset(AppImages.imgBtnStartPress),
          unpressedImage: Image.asset(AppImages.imgBtnStart),
        ),
        const SizedBox(
          height: 15,
        ),
        WidgetImageButton(
          onTap: _viewModel.goToMoreApp,
          width: width,
          height: width / 3,
          pressedImage: Image.asset(AppImages.imgBtnGameHotPress),
          unpressedImage: Image.asset(AppImages.imgBtnGameHot),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }

  Widget _buildLogo() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(top: 15, bottom: 35, left: 15, right: 15),
      child: Image.asset(
        AppImages.imgBanner,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildRowButton() {
    double size = 35;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        WidgetImageButton(
          width: size,
          height: size,
          pressedImage: Image.asset(AppImages.imgBtnLinkPress),
          unpressedImage: Image.asset(AppImages.imgBtnLink),
        ),
        const SizedBox(
          width: 8,
        ),
        WidgetImageButton(
          width: size,
          height: size,
          pressedImage: Image.asset(AppImages.imgBtnLikePress),
          unpressedImage: Image.asset(AppImages.imgBtnLike),
        ),
        const SizedBox(
          width: 8,
        ),
        StreamBuilder<ProcessModel>(
            stream: AppShared.watchProcess(),
            builder: (context, snapshot) {
              bool status = snapshot.data?.sound ?? true;
              return GestureDetector(
                onTap: () {
                  if (!status)
                    AppSound.playLoopBackground("music_bg.mp3");
                  else
                    AppSound.stopSound(type: StopSoundType.loop);
                  AppShared.setProcess(ProcessModel(sound: !status));
                },
                child: Image.asset(
                  !status ? AppImages.imgBtnSoundOff : AppImages.imgBtnSoundOn,
                  width: size,
                  height: size,
                ),
              );
            }),
      ],
    );
  }
}
