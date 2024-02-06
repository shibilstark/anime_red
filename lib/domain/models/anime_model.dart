import 'package:anime_red/domain/models/episode_model.dart';
import 'package:equatable/equatable.dart';

class AnimeModel extends Equatable {
  final String id;
  final String title;
  final String image;
  final String subOrDub;
  final String? type;
  final String? description;
  final String status;
  final List<String> genres;
  final String url;
  final String? otherName;
  final int episodeCount;
  final List<EpisodeModel> episodes;
  final String? releaseDate;

  const AnimeModel({
    required this.id,
    required this.title,
    required this.image,
    required this.url,
    required this.genres,
    required this.description,
    required this.episodeCount,
    required this.otherName,
    required this.status,
    required this.subOrDub,
    required this.type,
    required this.episodes,
    required this.releaseDate,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        url,
        genres,
        description,
        episodeCount,
        otherName,
        status,
        subOrDub,
        type,
        episodes,
      ];
}
