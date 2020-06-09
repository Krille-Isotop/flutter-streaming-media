import 'package:flutter/material.dart';

class LightRedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Light Red Screen')
      ),
      body: Container(
        color: Colors.red[400],
        child: Center(
          child: Text(
            'Light Red Screen',
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