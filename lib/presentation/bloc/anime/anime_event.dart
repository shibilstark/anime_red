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
  final ServerModel server;
  final String episodeId;
  const AnimeChangeStreamingServer(
      {required this.server, required this.episodeId});
}

class AnimeChangeStreamingQuality extends AnimeEvent {
  final StreamingQuality quality;
  final String currentEpisodeId;
  const AnimeChangeStreamingQuality(this.quality, this.currentEpisodeId);
}

class AnimePlayLastPlayedEpisode extends AnimeEvent {
  final String animeId;
  const AnimePlayLastPlayedEpisode(this.animeId);
}

// class AnimeUpdateLastPlayedPosition extends AnimeEvent {
//   final Duration lastPostion;
//   final String id;
//   final String episodeId;
//   const AnimeUpdateLastPlayedPosition({
//     required this.episodeId,
//     required this.id,
//     required this.lastPostion,
//   });
//   @override
//   List<Object> get props => [lastPostion];
// }
