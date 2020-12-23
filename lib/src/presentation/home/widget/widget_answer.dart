import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:dovuihainao_flutter/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetAnswer extends StatefulWidget {
  final String value;
  final bool status;
  final Function action;

  const WidgetAnswer({this.status = false, this.value, this.action});

  @override
  _WidgetAnswerState createState() => _WidgetAnswerState();
}

class _WidgetAnswerState extends State<WidgetAnswer> {
  @override
  Widget build(BuildContext context) {
    double width = Get.width * 4 / 5;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        children: [
          WidgetImageButton(
            width: Get.width * 4 / 5,
            height: width / 5,
            onTap: widget.action,
            children: [
              Text(
                widget.value ?? "",
                style:
                    AppStyles.DEFAULT_MEDIUM_BOLD.copyWith(color: Colors.white),
              )
            ],
            unpressedImage: Image.asset(widget.status
                ? AppImages.bgAnswerGreen
                : AppImages.bgAnswerRed),
            pressedImage: Image.asset(AppImages.bgAnswerGreen),
          ),
          Positioned(
              left: 0,
              child: Container(
                width: width / 5,
                height: width / 5,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
