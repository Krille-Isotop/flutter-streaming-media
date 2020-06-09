import 'package:flutter/material.dart';
import 'package:flutter_navigation_guide/navigation/route_generator.dart';

class RedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RedScreen')
      ),
      body: Container(
        width: double.infinity,
        color: Colors.red[700],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
            'Red Screen',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40.0
            ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed(RouteGenerator.lightRed),
              color: Colors.red[900],
              child: Text(
                'Go to Light Red Screen',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                ),
              ),
            ),
          ], 
        )
      )
    );
  }
}