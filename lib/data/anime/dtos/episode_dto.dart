import 'package:anime_red/domain/models/episode_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'episode_dto.g.dart';

@JsonSerializable()
class EpisodeDto {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "url")
  final String url;
  @JsonKey(name: "number")
  final int episodeNumber;

  const EpisodeDto({
    required this.id,
    required this.url,
    required this.episodeNumber,
  });

  factory EpisodeDto.fromJson(Map<String, dynamic> json) {
    return _$EpisodeDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EpisodeDtoToJson(this);

  EpisodeModel toModel() => EpisodeModel(
        id: id,
        url: url,
        episodeNumber: episodeNumber,
      );
}
