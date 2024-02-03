// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_streaminglink_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeStreamingLinkDto _$AnimeStreamingLinkDtoFromJson(
        Map<String, dynamic> json) =>
    AnimeStreamingLinkDto(
      headers:
          StreamingHeadersDto.fromJson(json['headers'] as Map<String, dynamic>),
      sources: (json['sources'] as List<dynamic>)
          .map((e) => StreamingSourcesDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnimeStreamingLinkDtoToJson(
        AnimeStreamingLinkDto instance) =>
    <String, dynamic>{
      'headers': instance.headers,
      'sources': instance.sources,
    };

StreamingHeadersDto _$StreamingHeadersDtoFromJson(Map<String, dynamic> json) =>
    StreamingHeadersDto(
      referer: json['Referer'] as String,
      watchsb: json['watchsb'] as String?,
      userAgent: json['User-Agent'] as String?,
    );

Map<String, dynamic> _$StreamingHeadersDtoToJson(
        StreamingHeadersDto instance) =>
    <String, dynamic>{
      'Referer': instance.referer,
      'watchsb': instance.watchsb,
      'User-Agent': instance.userAgent,
    };

StreamingSourcesDto _$StreamingSourcesDtoFromJson(Map<String, dynamic> json) =>
    StreamingSourcesDto(
      url: json['url'] as String,
      quality: json['quality'] as String,
      isM3U8: json['isM3U8'] as bool,
    );

Map<String, dynamic> _$StreamingSourcesDtoToJson(
        StreamingSourcesDto instance) =>
    <String, dynamic>{
      'url': instance.url,
      'quality': instance.quality,
      'isM3U8': instance.isM3U8,
    };
