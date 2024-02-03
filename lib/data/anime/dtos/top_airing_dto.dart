import 'package:anime_red/domain/models/top_airing_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'top_airing_dto.g.dart';

@JsonSerializable()
class TopAiringDto {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "image")
  final String image;
  @JsonKey(name: "genres")
  final List<String> genres;
  @JsonKey(name: "url")
  final String url;

  const TopAiringDto({
    required this.id,
    required this.title,
    required this.image,
    required this.url,
    required this.genres,
  });

  factory TopAiringDto.fromJson(Map<String, dynamic> json) {
    return _$TopAiringDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TopAiringDtoToJson(this);

  static TopAiringDto fromJsonModel(Map<String, dynamic> json) =>
      TopAiringDto.fromJson(json);

  TopAiringModel toModel() => TopAiringModel(
        id: id,
        title: title,
        image: image,
        url: url,
        genres: genres,
      );
}
