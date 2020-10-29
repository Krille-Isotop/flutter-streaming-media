import 'dart:convert';

import 'package:flutter_navigation_guide/dto/entry.dart';
import 'package:flutter_navigation_guide/dto/episode.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  Future<EntryList> getEntries() async {
    final response = await http.get(
        'https://origin-www.svt.se/oppet-arkiv-api/search/videos/?q=Rederiet&pretty=true');

    if (response.statusCode == 200) {
      return EntryList.fromJson(json.decode(response.body)["entries"]);
    }

    return null;
  }

  Future<EpisodeList> getEpisodes() async {
    final response = await http.get(
        'http://api.sr.se/api/v2/episodes/index?programid=3718&fromdate=2012-08-01&todate=2012-08-31&audioquality=hi&format=json');

    if (response.statusCode == 200) {
      return EpisodeList.fromJson(json.decode(response.body)["episodes"]);
    }

    return null;
  }
}
