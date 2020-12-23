import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class WidgetVictory extends StatelessWidget {
  final BehaviorSubject<bool> victorySubject;
  final Function callback;

  const WidgetVictory({this.victorySubject, this.callback});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: victorySubject,
        builder: (context, snapshot) {
          bool status = snapshot.data ?? false;
          return AnimatedPositioned(
              top: 200,
              left: !status ? -200 : (Get.width - 200) / 2,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.red,
                child: Center(
                  child: FlatButton(
                    onPressed: callback ?? (){},
                    child: Text("Next"),
                  ),
                ),
              ),
              duration: Duration(milliseconds: 250));
        });
  }
}
