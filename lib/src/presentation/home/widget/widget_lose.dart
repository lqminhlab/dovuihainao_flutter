import 'package:dovuihainao_flutter/src/configs/constanst/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../presentation.dart';

class WidgetLose extends StatelessWidget {
  final BehaviorSubject<bool> loseSubject;
  final BehaviorSubject<String> explainSubject;
  final Animation animation;
  final Function callback;

  const WidgetLose(
      {this.loseSubject, this.callback, this.explainSubject, this.animation});

  @override
  Widget build(BuildContext context) {
    double width = Get.width * 9 / 10;
    double height = Get.height - Get.width / 10;
    double padding = Get.width / 10;
    return StreamBuilder<bool>(
        stream: loseSubject,
        builder: (context, snapshot) {
          bool status = snapshot.data ?? false;
          return AnimatedPositioned(
              top: padding,
              left: !status ? -width : padding / 2,
              child: AnimatedOpacity(
                opacity: status ? 1 : 0,
                duration: Duration(milliseconds: 250),
                child: Container(
                    width: width,
                    height: height,
                    child: Stack(
                      children: [
                        Positioned(
                          top: width * 2 / 3 - width / 2,
                          left: width / 2 - (width * 3 / 5) / 2,
                          child: Image.asset(
                            AppImages.imgLoseFace,
                            width: width * 3 / 5,
                            height: width * 3 / 5,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: width * 2 / 3 - width / 2,
                          left: width * 3 / 5 - width / 2,
                          child: AnimatedBuilder(
                            animation: animation,
                            child: Image.asset(
                              AppImages.imgLoseHand,
                              width: width * 1.5 / 5,
                              height: width * 1.5 / 5,
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
                        Positioned(
                          // top: width * 2 / 3,
                          top: width * 2 / 3 - width / 2 + width * 3 / 5,
                          child: Container(
                            width: width,
                            height: width / 2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppImages.bgBoardMoreApp),
                                    fit: BoxFit.fill)),
                            child: Center(
                              child: StreamBuilder<String>(
                                  stream: explainSubject,
                                  builder: (context, snapshot) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      child: Text(
                                        "${snapshot.data}",
                                        style: AppStyles.DEFAULT_MEDIUM_BOLD
                                            .copyWith(color: Colors.white),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                        Positioned(
                          left: width / 2 - width / 6,
                          top: width * 2 / 3 +
                              width / 2 -
                              width / 12 -
                              width / 2 +
                              width * 3 / 5,
                          child: WidgetImageButton(
                            onTap: callback,
                            width: width / 3,
                            height: width / 6,
                            pressedImage:
                                Image.asset(AppImages.imgBtnAgainPress),
                            unpressedImage: Image.asset(AppImages.imgBtnAgain),
                          ),
                        )
                      ],
                    )),
              ),
              duration: Duration(milliseconds: 250));
        });
  }
}
