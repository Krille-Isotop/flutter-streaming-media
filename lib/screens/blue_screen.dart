import 'package:flutter/material.dart';
import 'package:flutter_navigation_guide/dto/entry.dart';
import 'package:flutter_navigation_guide/network_service.dart';
import 'package:flutter_navigation_guide/widgets/player.dart';

class BlueScreen extends StatelessWidget {
  final NetworkService networkService = NetworkService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Blue Screen')),
        body: Container(
          child: FutureBuilder<EntryList>(
            future: networkService.getEntries(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasError && snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.entries.length,
                    itemBuilder: (context, index) {
                      return Player(snapshot.data.entries[index].url
                          .replaceFirst("http", "https"));
                    });
              }

              return SizedBox.shrink();
            },
          ),
        ));
  }
}
