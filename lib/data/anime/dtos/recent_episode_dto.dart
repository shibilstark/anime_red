import 'package:json_annotation/json_annotation.dart';

part 'recent_episode_dto.g.dart';

@JsonSerializable()
class RecentEpisodeDto {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "image")
  final String image;
  @JsonKey(name: "episodeId")
  final String eposodeId;
  @JsonKey(name: "url")
  final String url;
  @JsonKey(name: "episodeNumber")
  final int episodeNumber;

  const RecentEpisodeDto({
    required this.id,
    required this.title,
    required this.image,
    required this.url,
    required this.episodeNumber,
    required this.eposodeId,
  });

  factory RecentEpisodeDto.fromJson(Map<String, dynamic> json) {
    return _$RecentEpisodeDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RecentEpisodeDtoToJson(this);

  static RecentEpisodeDto fromJsonModel(Map<String, dynamic> json) =>
      RecentEpisodeDto.fromJson(json);
}
