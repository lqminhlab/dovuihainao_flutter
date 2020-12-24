import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../presentation.dart';

class WidgetVictory extends StatelessWidget {
  final BehaviorSubject<bool> victorySubject;
  final BehaviorSubject<String> explainSubject;
  final Animation animationHand;
  final Function callback;

  const WidgetVictory(
      {this.victorySubject,
      this.callback,
      this.explainSubject,
      this.animationHand});

  @override
  Widget build(BuildContext context) {
    double width = Get.width * 9 / 10;
    double height = Get.height - Get.width / 10;
    double padding = Get.width / 10;
    return StreamBuilder<bool>(
        stream: victorySubject,
        builder: (context, snapshot) {
          bool status = snapshot.data ?? false;
          return AnimatedPositioned(
              top: padding,
              left: !status ? -width : padding / 2,
              child: Container(
                  width: width,
                  height: height,
                  child: Stack(
                    children: [
                      AnimatedBuilder(
                        animation: animationHand,
                        builder: (context, child) {
                          return Transform.scale(
                              scale: animationHand.value, child: child);
                        },
                        child: Image.asset(
                          AppImages.bgStars,
                          width: width,
                          height: width * 2 / 3,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: width * 2 / 3 - width / 2,
                        left: width / 2 - (width * 3 / 5) / 2,
                        child: Image.asset(
                          AppImages.imgVictoryFace,
                          width: width * 3 / 5,
                          height: width * 3 / 5,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: width * 2 / 3 - width / 2,
                        child: AnimatedBuilder(
                          animation: animationHand,
                          builder: (context, child) {
                            return Transform.scale(
                                scale: animationHand.value,
                                alignment: Alignment.centerRight,
                                origin: Offset(1, 0.5),
                                child: child);
                          },
                          child: Image.asset(
                            AppImages.imgVictoryHand,
                            width: width * 2 / 5,
                            height: width * 3 / 7,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: width * 2 / 3,
                        child: Container(
                          width: width,
                          height: width / 2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(AppImages.bgBoardMoreApp),
                                  fit: BoxFit.fill)),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: StreamBuilder<String>(
                                stream: explainSubject,
                                builder: (context, snapshot) {
                                  return Text(
                                    "${snapshot.data}",
                                    style: AppStyles.DEFAULT_MEDIUM_BOLD
                                        .copyWith(color: Colors.white),
                                  );
                                }),
                          ),
                        ),
                      ),
                      Positioned(
                        left: width / 2 - width / 6,
                        top: width * 2 / 3 + width / 2 - width / 12,
                        child: WidgetImageButton(
                          onTap: callback,
                          width: width / 3,
                          height: width / 6,
                          pressedImage:
                              Image.asset(AppImages.imgBtnContinuePress),
                          unpressedImage: Image.asset(AppImages.imgBtnContinue),
                        ),
                      )
                    ],
                  )),
              duration: Duration(milliseconds: 250));
        });
  }
}
