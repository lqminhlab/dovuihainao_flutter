import 'package:dovuihainao_flutter/src/presentation/presentation.dart';
import 'package:flutter/material.dart';

class Routers {
  static const String splash = "/";
  static const String start = "/start";
  static const String home = "/home";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return animRoute(SplashScreen());
        break;
      case start:
        return animRoute(StartScreen());
        break;
      case home:
        return animRoute(HomeScreen());
        break;
      default:
        return animRoute(Container(
            child:
                Center(child: Text('No route defined for ${settings.name}'))
          )
        );
    }
  }

  static Route animRoute(Widget page,
      {Offset beginOffset, String name, Object arguments}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: name, arguments: arguments),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = beginOffset ?? Offset(0.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Offset center = Offset(0.0, 0.0);
  static Offset top = Offset(0.0, 1.0);
  static Offset bottom = Offset(0.0, -1.0);
  static Offset left = Offset(-1.0, 0.0);
  static Offset right = Offset(1.0, 0.0);
}
