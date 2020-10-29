import 'package:flutter/material.dart';
import 'navigation/router.dart' as navigation;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: navigation.Router(),
    );
  }
}
