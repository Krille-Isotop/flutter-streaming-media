import 'package:flutter/material.dart';
import 'package:flutter_navigation_guide/dto/entry.dart';
import 'package:flutter_navigation_guide/network_service.dart';

class BlueScreen extends StatelessWidget {
  final NetworkService networkService = NetworkService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Blue Screen')),
        body: Container(
          child: FutureBuilder<EntryList>(
            future: networkService.getEntries(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasError && snapshot.hasData) {
                return Text("hej");
              }

              return null;
            },
          ),
        ));
  }
}
