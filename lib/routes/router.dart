import 'package:charted/driver.dart';
import 'package:charted/pages/charts.dart';
import 'package:charted/pages/createchart.dart';
import 'package:charted/pages/home.dart';
import 'package:charted/pages/signup.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.driver:
        return MaterialPageRoute(builder: (_) => Driver());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case Routes.charts:
        return MaterialPageRoute(builder: (_) => const ChartsPage());
      case Routes.createChart:
        return MaterialPageRoute(builder: (_) => CreateChartPage());
      default:
        return MaterialPageRoute(builder: (_) => Driver());
    }
  }
}

class Routes {
  static const String home = HomePage.routeName;
  static const String signup = SignUpPage.routeName;
  static const String charts = ChartsPage.routeName;
  static const String createChart = CreateChartPage.routeName;
  static const String driver = '/';
}
