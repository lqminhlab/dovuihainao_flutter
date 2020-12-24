import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:dovuihainao_flutter/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnswerModel {
  final Function action;
  final String value;

  const AnswerModel({this.action, this.value});
}

class WidgetAnswer extends StatelessWidget {
  final String icon;
  final AnswerModel answer;

  const WidgetAnswer({this.answer, this.icon});

  @override
  Widget build(BuildContext context) {
    double width = Get.width * 4 / 5;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          WidgetImageButton(
            width: width,
            height: width / 5,
            onTap: answer.action,
            children: [
              Container(
                width: width,
                constraints: BoxConstraints(maxWidth: width),
                padding: EdgeInsets.only(left: width / 5 + 5, right: 12),
                child: Text(
                  "${answer.value ?? ""}",
                  style: AppStyles.DEFAULT_MEDIUM_BOLD
                      .copyWith(color: Colors.white),
                ),
              )
            ],
            unpressedImage: Image.asset(AppImages.bgAnswerRed),
            pressedImage: Image.asset(AppImages.bgAnswerGreen),
          ),
          Positioned(
              left: 0,
              bottom: 4,
              child: Container(
                width: width / 5,
                height: width / 5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(icon), fit: BoxFit.fill)),
              ))
        ],
      ),
    );
  }
}
