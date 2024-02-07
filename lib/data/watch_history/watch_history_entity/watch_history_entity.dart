import 'package:hive/hive.dart';

import '../../../domain/watch_history/watch_history_model.dart/watch_history_model.dart';

part 'watch_history_entity.g.dart';

@HiveType(typeId: 1)
class WatchHistoryEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String episodeId;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final Duration? currentPosition;
  @HiveField(5)
  final int currentEpisodeCount;
  @HiveField(6)
  final String subOrDub;
  @HiveField(7)
  final List<String> genres;
  @HiveField(8)
  final DateTime lastUpdatedAt;
  @HiveField(9)
  final Duration? totalLength;

  const WatchHistoryEntity({
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

  WatchHistoryModel toModel() {
    return WatchHistoryModel(
      id: id,
      image: image,
      title: title,
      episodeId: episodeId,
      currentPosition: currentPosition,
      currentEpisodeCount: currentEpisodeCount,
      subOrDub: subOrDub,
      genres: genres,
      lastUpdatedAt: lastUpdatedAt,
      totalLength: totalLength,
    );
  }

  WatchHistoryEntity updateStatus({
    required String newEpisodeId,
    required Duration newPosition,
    required Duration newTotalLength,
  }) {
    return WatchHistoryEntity(
      id: id,
      image: image,
      title: title,
      episodeId: newEpisodeId,
      currentPosition: newPosition,
      currentEpisodeCount: currentEpisodeCount,
      subOrDub: subOrDub,
      genres: genres,
      lastUpdatedAt: DateTime.now(),
      totalLength: newTotalLength,
    );
  }

  factory WatchHistoryEntity.fromModel(WatchHistoryModel model) {
    return WatchHistoryEntity(
      id: model.id,
      image: model.image,
      title: model.title,
      episodeId: model.episodeId,
      currentPosition: model.currentPosition,
      currentEpisodeCount: model.currentEpisodeCount,
      subOrDub: model.subOrDub,
      genres: model.genres,
      lastUpdatedAt: model.lastUpdatedAt,
      totalLength: model.totalLength,
    );
  }
}
