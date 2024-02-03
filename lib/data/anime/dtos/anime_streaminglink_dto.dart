import 'package:anime_red/domain/models/anime_streaminglink_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/common_types/enums.dart';

part 'anime_streaminglink_dto.g.dart';

@JsonSerializable()
class AnimeStreamingLinkDto {
  @JsonKey(name: "headers")
  final StreamingHeadersDto headers;
  @JsonKey(name: "sources")
  final List<StreamingSourcesDto> sources;

  const AnimeStreamingLinkDto({
    required this.headers,
    required this.sources,
  });
  factory AnimeStreamingLinkDto.fromJson(Map<String, dynamic> json) {
    return _$AnimeStreamingLinkDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AnimeStreamingLinkDtoToJson(this);

  AnimeStreamingLinkModel toModel() => AnimeStreamingLinkModel(
        headers: headers.toModel(),
        sources: sources.map((e) => e.toModel()).toList(),
      );
}

@JsonSerializable()
class StreamingHeadersDto {
  @JsonKey(name: "Referer")
  final String referer;
  @JsonKey(name: "watchsb")
  final String? watchsb;
  @JsonKey(name: "User-Agent")
  final String? userAgent;

  const StreamingHeadersDto({
    required this.referer,
    required this.watchsb,
    required this.userAgent,
  });
  factory StreamingHeadersDto.fromJson(Map<String, dynamic> json) {
    return _$StreamingHeadersDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StreamingHeadersDtoToJson(this);

  StreamingHeadersModel toModel() => StreamingHeadersModel(
        referer: referer,
        watchsb: watchsb,
        userAgent: userAgent,
      );
}

@JsonSerializable()
class StreamingSourcesDto {
  @JsonKey(name: "url")
  final String url;
  @JsonKey(name: "quality")
  final String quality;
  @JsonKey(name: "isM3U8")
  final bool isM3U8;

  const StreamingSourcesDto({
    required this.url,
    required this.quality,
    required this.isM3U8,
  });
  factory StreamingSourcesDto.fromJson(Map<String, dynamic> json) {
    return _$StreamingSourcesDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StreamingSourcesDtoToJson(this);

  StreamingSourcesModel toModel() => StreamingSourcesModel(
        url: url,
        quality: StreamingQuality.fromString(quality),
        isM3U8: isM3U8,
      );
}
