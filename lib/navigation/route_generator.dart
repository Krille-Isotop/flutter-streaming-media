import 'package:flutter/material.dart';
import 'package:flutter_navigation_guide/screens/blue_screen.dart';
import 'package:flutter_navigation_guide/screens/light_blue_screen.dart';
import 'package:flutter_navigation_guide/screens/light_red_screen.dart';
import 'package:flutter_navigation_guide/screens/red_screen.dart';

class RouteGenerator {
  static const String red = 'red';
  static const String blue = 'blue';
  static const String lightRed = 'LightRed';
  static const String lightBlue = 'lightBlue';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case red:
        return MaterialPageRoute(builder: (_) => RedScreen());
      case blue:
        return MaterialPageRoute(builder: (_) => BlueScreen());
      case lightRed:
        return MaterialPageRoute(builder: (_) => LightRedScreen());
      case lightBlue:
        return MaterialPageRoute(builder: (_) => LightBlueScreen());
      default:        
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('ERROR')),
      );
    });
  }
}