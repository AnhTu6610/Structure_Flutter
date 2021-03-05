import 'package:flutter/material.dart';

import 'package:structure_example/views/home/home_screen.dart';
import 'package:structure_example/views/splash/splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:structure_example/utils/log_debug.dart';

class GenerateRoute {
  PageTransition checkRoute(RouteSettings setting) {
    log(setting.name.toString(), "Route <--|");

    switch (setting.name) {
      case '/home':
        return _pageRoute(setting, HomeScreen(), transition: PageTransitionType.fade);
      case '/splash':
        return _pageRoute(setting, SplashScreen());
      //-- default
      default:
        return _pageRoute(RouteSettings(name: "/splash"), SplashScreen());
    }
  }

  PageTransition _pageRoute(RouteSettings setting, Widget page, {PageTransitionType transition}) => PageTransition(
        child: page,
        type: transition ?? PageTransitionType.rightToLeft,
        settings: RouteSettings(name: setting.name, arguments: setting.arguments),
      );
}
