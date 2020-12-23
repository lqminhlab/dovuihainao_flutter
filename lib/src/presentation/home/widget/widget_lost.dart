import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class WidgetLost extends StatelessWidget {
  final BehaviorSubject<bool> lostSubject;
  final Function callback;

  const WidgetLost({this.lostSubject, this.callback});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: lostSubject,
        builder: (context, snapshot) {
          bool status = snapshot.data ?? false;
          return AnimatedPositioned(
              top: 200,
              right: !status ? - 200 : (Get.width - 200)/2,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.grey,
                child: Center(
                  child: FlatButton(
                    onPressed: callback ?? (){},
                    child: Text("Again"),
                  ),
                ),
              ),
              duration: Duration(milliseconds: 250));
        });
  }
}
