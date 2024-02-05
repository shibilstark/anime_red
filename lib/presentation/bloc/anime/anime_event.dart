part of 'anime_bloc.dart';

sealed class AnimeEvent extends Equatable {
  const AnimeEvent();

  @override
  List<Object> get props => [];
}

class AnimeGetInfo extends AnimeEvent {
  final String id;
  const AnimeGetInfo(this.id);
}

class AnimeGetEpisodeLink extends AnimeEvent {
  final String episodeId;
  const AnimeGetEpisodeLink(this.episodeId);
}

class AnimeChangeStreamingServer extends AnimeEvent {
  final AnimeServerName server;
  final String episodeId;
  const AnimeChangeStreamingServer(
      {required this.server, required this.episodeId});
}

class AnimeChangeStreamingQuality extends AnimeEvent {
  final StreamingQuality quality;
  const AnimeChangeStreamingQuality(this.quality);
}
