import 'package:flutter/material.dart';
import 'package:flutter_navigation_guide/dto/episode.dart';
import 'package:flutter_navigation_guide/network_service.dart';
import 'package:flutter_navigation_guide/widgets/player.dart';

class RedScreen extends StatelessWidget {
  final NetworkService networkService = NetworkService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Red Screen')),
        body: Container(
          child: FutureBuilder<EpisodeList>(
            future: networkService.getEpisodes(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasError && snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.episodes.length,
                    itemBuilder: (context, index) {
                      final episode = snapshot.data.episodes[index];
                      return Player(episode.url.replaceFirst("http", "https"),
                          showVideo: false, imageUrl: episode.imageUrl);
                    });
              }

              return SizedBox.shrink();
            },
          ),
        ));
  }
}
