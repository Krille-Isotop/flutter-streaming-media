import 'package:flutter/material.dart';

class LightBlueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Light Blue Screen')
      ),
      body: Container(
        color: Colors.lightBlue[700],
        child: Center(
          child: Text(
            'Light Blue Screen',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40.0
            ),
          ),
        )
      )
    );
  }
}