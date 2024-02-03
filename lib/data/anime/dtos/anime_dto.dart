import 'package:anime_red/data/anime/dtos/episode_dto.dart';
import 'package:anime_red/domain/models/anime_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'anime_dto.g.dart';

@JsonSerializable()
class AnimeDto {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "image")
  final String image;
  @JsonKey(name: "subOrDub")
  final String subOrDub;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "genres")
  final List<String> genres;
  @JsonKey(name: "url")
  final String url;
  @JsonKey(name: "otherName")
  final String otherName;
  @JsonKey(name: "totalEpisodes")
  final int episodeCount;
  @JsonKey(name: "episodes")
  final List<EpisodeDto> episodes;
  @JsonKey(name: "releaseDate")
  final String? releaseDate;

  const AnimeDto({
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

  factory AnimeDto.fromJson(Map<String, dynamic> json) {
    return _$AnimeDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AnimeDtoToJson(this);

  AnimeModel toModel() => AnimeModel(
        id: id,
        title: title,
        image: image,
        url: url,
        genres: genres,
        description: description,
        episodeCount: episodeCount,
        otherName: otherName,
        status: status,
        subOrDub: subOrDub,
        type: type,
        episodes: episodes.map((e) => e.toModel()).toList(),
        releaseDate: releaseDate,
      );
}
