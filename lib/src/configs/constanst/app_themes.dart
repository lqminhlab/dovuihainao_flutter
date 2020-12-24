import 'package:flutter/material.dart';

import 'constants.dart';

normalTheme(BuildContext context){
  return ThemeData(
    fontFamily: AppStyles.FONT_ITIM,
    primarySwatch: Colors.amber,
    primaryColorLight: Colors.yellowAccent,
    disabledColor: Colors.grey,
    cardColor: Colors.white,
    canvasColor: Colors.white,
    brightness: Brightness.light,
    buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: ColorScheme.light(),
        buttonColor: Colors.amber,
        splashColor: Colors.yellowAccent),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
  );
}
