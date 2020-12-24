import 'package:dovuihainao_flutter/src/configs/constanst/constants.dart';
import 'package:dovuihainao_flutter/src/resource/model/model.dart';
import 'package:dovuihainao_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../presentation.dart';

class WidgetAppBar extends StatelessWidget {
  static const double HEIGHT_APP_BAR = 60;

  final Function actionShareQuestion;

  const WidgetAppBar({this.actionShareQuestion});

  @override
  Widget build(BuildContext context) {
    double size = 40;
    double sizeHeart = 45;
    return Container(
      height: HEIGHT_APP_BAR,
      width: double.maxFinite,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.bgAppBar), fit: BoxFit.fill)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 12,
          ),
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
          Spacer(),
          Container(
              width: sizeHeart,
              height: sizeHeart,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppImages.icHeart))),
              padding: const EdgeInsets.all(12),
              child: StreamBuilder<ProcessModel>(
                stream: AppShared.watchProcess(),
                builder: (context, snapshot) {
                  return FittedBox(
                      child: Text(
                    "${snapshot.data?.heart ?? 0}",
                    style: AppStyles.DEFAULT_MEDIUM_BOLD
                        .copyWith(color: Colors.white),
                  ));
                },
              )),
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Image.asset(
          //       AppImages.icHeart,
          //       width: sizeHeart,
          //       height: sizeHeart,
          //     ),
          //     StreamBuilder<ProcessModel>(
          //       stream: AppShared.watchProcess(),
          //       builder: (context, snapshot) {
          //         return Text("${snapshot.data?.heart ?? 0}");
          //       },
          //     ),
          //   ],
          // ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: WidgetImageButton(
              onTap: actionShareQuestion,
              width: size,
              height: size,
              pressedImage: Image.asset(AppImages.imgBtnLinkScreenshotPress),
              unpressedImage: Image.asset(AppImages.imgBtnLinkScreenshot),
            ),
          ),
          const SizedBox(
            width: 12,
          )
        ],
      ),
    );
  }
}
