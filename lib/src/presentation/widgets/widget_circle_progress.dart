import 'package:flutter/material.dart';

class WidgetCircleProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 45,
        height: 45,
        padding: EdgeInsets.all(5),
        child: CircularProgressIndicator(
          strokeWidth: 3.5,
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorDark),
          backgroundColor: Theme.of(context).primaryColorLight,
        ));
  }
}
