import 'package:flutter/material.dart';
import 'package:movie/ui/pages/error_page/error_page.dart';
import 'package:movie/ui/pages/home_page/home_page.dart';
import 'package:movie/ui/routes/app_routes.dart';


class AppNavigator {
  static String initRoute = AppRoutes.home;

  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.home: (_) => const HomePage(),
    };
  }

  static Route generate(RouteSettings settings) {
    final _settings = RouteSettings(
      name: '/404',
      arguments: settings.arguments,
    );

    return MaterialPageRoute(
      settings: _settings,
      builder: (_) => const ErrorPage(),
    );
  }
}
