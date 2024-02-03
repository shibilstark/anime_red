enum FailureType {
  client,
  server,
  unknown,
  internet,
}

enum StreamingQuality {
  defaultQuality,
  backupQuality,
  quality360p,
  quality480p,
  quality720p,
  quality1080p,
}

enum AnimeType {
  japanese,
  english,
  chinese;

  int get queryValue {
    switch (this) {
      case AnimeType.japanese:
        return 1;
      case AnimeType.english:
        return 2;
      case AnimeType.chinese:
        return 3;
      default:
        return 1;
    }
  }
}

enum AnimeServerName {
  gogocdn,
  streamsb,
  vidstreaming;

  String get queryValue {
    switch (this) {
      case AnimeServerName.gogocdn:
        return "gogocdn";
      case AnimeServerName.streamsb:
        return "streamsb";
      case AnimeServerName.vidstreaming:
        return "vidstreaming";
      default:
        return "gogocdn";
    }
  }
}
