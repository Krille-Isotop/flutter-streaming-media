import 'dart:convert';

import 'package:flutter_navigation_guide/dto/entry.dart';
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
}
