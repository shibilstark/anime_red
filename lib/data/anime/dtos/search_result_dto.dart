import 'package:json_annotation/json_annotation.dart';

part 'search_result_dto.g.dart';

@JsonSerializable()
class SearchResultDto {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "image")
  final String image;
  @JsonKey(name: "subOrDub")
  final String subOrDub;
  @JsonKey(name: "releaseDate")
  final String? releaseDate;

  const SearchResultDto({
    required this.id,
    required this.title,
    required this.image,
    required this.subOrDub,
    required this.releaseDate,
  });

  factory SearchResultDto.fromJson(Map<String, dynamic> json) {
    return _$SearchResultDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchResultDtoToJson(this);

  static SearchResultDto fromJsonModel(Map<String, dynamic> json) =>
      SearchResultDto.fromJson(json);
}
