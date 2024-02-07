import 'package:equatable/equatable.dart';

class WatchHistoryModel extends Equatable {
  final String id;
  final String episodeId;
  final String title;
  final String image;
  final Duration? currentPosition;
  final Duration? totalLength;
  final int currentEpisodeCount;
  final String subOrDub;
  final List<String> genres;
  final DateTime lastUpdatedAt;

  const WatchHistoryModel({
    required this.id,
    required this.image,
    required this.title,
    required this.episodeId,
    required this.currentPosition,
    required this.currentEpisodeCount,
    required this.subOrDub,
    required this.genres,
    required this.lastUpdatedAt,
    required this.totalLength,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        title,
        episodeId,
        currentPosition,
        currentEpisodeCount,
        subOrDub,
        genres,
        lastUpdatedAt,
        totalLength,
      ];
}
