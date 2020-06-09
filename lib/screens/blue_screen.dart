import 'package:flutter/material.dart';
import 'package:flutter_navigation_guide/navigation/route_generator.dart';

class BlueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blue Screen')
      ),
      body: Container(
        width: double.infinity,
        color: Colors.blue[700],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
            'Blue Screen',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40.0
            ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed(RouteGenerator.lightBlue),
              color: Colors.blue[900],
              child: Text(
                'Go to Light Blue Screen',
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