class Episode {
  final String title;
  final String url;
  final String description;
  final String imageUrl;

  Episode({this.title, this.url, this.description, this.imageUrl});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
        title: json["title"],
        description: json["description"],
        url: json["listenpodfile"]["url"],
        imageUrl: json["imageurl"]);
  }
}

class EpisodeList {
  final List<Episode> episodes;

  EpisodeList({this.episodes});

  factory EpisodeList.fromJson(List<dynamic> json) {
    return EpisodeList(episodes: json.map((c) => Episode.fromJson(c)).toList());
  }
}
