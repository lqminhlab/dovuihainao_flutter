import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "NavigationScreen",
          style:
              AppStyles.DEFAULT_MEDIUM_BOLD.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
