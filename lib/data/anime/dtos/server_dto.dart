import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/models/server_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'server_dto.g.dart';

@JsonSerializable()
class ServerDto {
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "url")
  final String url;

  const ServerDto({
    required this.name,
    required this.url,
  });

  factory ServerDto.fromJson(Map<String, dynamic> json) {
    return _$ServerDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ServerDtoToJson(this);

  ServerModel toModel() =>
      ServerModel(name: AnimeServerName.fromString(name), url: url);
}
