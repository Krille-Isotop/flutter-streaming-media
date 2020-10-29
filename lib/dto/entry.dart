class Entry {
  final String programTitle;
  final String url;
  final String description;

  Entry({this.programTitle, this.url, this.description});

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
        programTitle: json["programTitle"],
        description: json["description"],
        url: VideoReferenceList.fromJson(json["videoReferences"])
            .videoReferences
            .firstWhere((element) => element.playerType == "hls")
            .url);
  }
}

class VideoReference {
  final String url;
  final String playerType;

  VideoReference(this.url, this.playerType);

  factory VideoReference.fromJson(Map<String, dynamic> json) {
    return VideoReference(json["url"], json["playerType"]);
  }
}

class VideoReferenceList {
  final List<VideoReference> videoReferences;

  VideoReferenceList({this.videoReferences});

  factory VideoReferenceList.fromJson(List<dynamic> json) {
    return VideoReferenceList(
        videoReferences: json.map((c) => VideoReference.fromJson(c)).toList());
  }
}

class EntryList {
  final List<Entry> entries;

  EntryList({this.entries});

  factory EntryList.fromJson(List<dynamic> json) {
    return EntryList(entries: json.map((c) => Entry.fromJson(c)).toList());
  }
}
