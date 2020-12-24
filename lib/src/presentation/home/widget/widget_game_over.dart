import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../presentation.dart';

class WidgetGameOver extends StatelessWidget {
  final BehaviorSubject<bool> gameOverSubject;
  final BehaviorSubject<String> explainSubject;
  final Animation animation;
  final Function callback;

  const WidgetGameOver(
      {this.gameOverSubject,
      this.callback,
      this.explainSubject,
      this.animation});

  @override
  Widget build(BuildContext context) {
    double width = Get.width * 9 / 10;
    double height = Get.height - Get.width / 10;
    double padding = Get.width / 10;
    return StreamBuilder<bool>(
        stream: gameOverSubject,
        builder: (context, snapshot) {
          bool status = snapshot.data ?? false;
          return AnimatedPositioned(
              bottom: status ? padding : - height,
              left: padding / 2,
              child: AnimatedOpacity(
                opacity: status ? 1 : 0,
                duration: Duration(milliseconds: 250),
                child: Container(
                    width: width,
                    height: height,
                    child: Stack(
                      children: [
                        Positioned(
                          top: width * 2 / 3,
                          child: Container(
                            width: width,
                            height: width / 2,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppImages.bgBoardMoreApp),
                                    fit: BoxFit.fill)),
                            child: Center(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Bạn đã hết lượt chơi ngày hôm nay!",
                                  style: AppStyles.DEFAULT_MEDIUM_BOLD
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                WidgetImageButton(
                                  onTap: callback,
                                  width: width / 3,
                                  height: width / 6,
                                  pressedImage:
                                      Image.asset(AppImages.imgBtnAgainPress),
                                  unpressedImage:
                                      Image.asset(AppImages.imgBtnAgain),
                                )
                              ],
                            )),
                          ),
                        ),
                        Positioned(
                          top: width * 2 / 3 - (width / 2) * 3 / 4,
                          left: width / 2 - (width / 2) / 2,
                          child: Image.asset(
                            AppImages.imgLoseFace,
                            width: width / 2,
                            height: width / 2,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: width * 2 / 3 - (width / 2) * 3 / 4,
                          left: width / 6,
                          child: AnimatedBuilder(
                            animation: animation,
                            child: Image.asset(
                              AppImages.imgLoseHand,
                              width: width * 1.2 / 5,
                              height: width * 1.2 / 5,
                              fit: BoxFit.fill,
                            ),
                            builder: (BuildContext context, Widget _widget) {
                              return Transform.translate(
                                offset: Offset(
                                    animation.value * 6, animation.value * 6),
                                child: _widget,
                              );
                            },
                          ),
                        ),
                      ],
                    )),
              ),
              duration: Duration(milliseconds: 250));
        });
  }
}
