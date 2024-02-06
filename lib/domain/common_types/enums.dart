enum FailureType {
  client,
  server,
  unknown,
  internet,
}

enum WatchListType {
  watching,
  onHold,
  planToWatch,
  dropped,
  completed,
}

enum StreamingQuality {
  defaultQuality,
  backupQuality,
  quality360p,
  quality480p,
  quality720p,
  quality1080p;

  static StreamingQuality fromString(String value) {
    switch (value) {
      case "backup":
        return StreamingQuality.backupQuality;
      case "360p":
        return StreamingQuality.quality360p;
      case "480p":
        return StreamingQuality.quality480p;
      case "720p":
        return StreamingQuality.quality720p;
      case "1080p":
        return StreamingQuality.quality1080p;
      case "default":
        return StreamingQuality.defaultQuality;

      default:
        return StreamingQuality.defaultQuality;
    }
  }

  String get toShowableString {
    switch (this) {
      case StreamingQuality.backupQuality:
        return "bakcup";
      case StreamingQuality.defaultQuality:
        return "default";
      case StreamingQuality.quality360p:
        return "360p";
      case StreamingQuality.quality480p:
        return "480p";
      case StreamingQuality.quality720p:
        return "720p";
      case StreamingQuality.quality1080p:
        return "1080p";
      default:
        return "default";
    }
  }
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

  static AnimeServerName fromString(String value) {
    switch (value) {
      case "gogocdn":
        return AnimeServerName.gogocdn;
      case "streamsb":
        return AnimeServerName.streamsb;
      case "vidstreaming":
        return AnimeServerName.vidstreaming;
      default:
        return AnimeServerName.gogocdn;
    }
  }
}
