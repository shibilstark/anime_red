// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeDto _$EpisodeDtoFromJson(Map<String, dynamic> json) => EpisodeDto(
      id: json['id'] as String,
      url: json['url'] as String,
      episodeNumber: json['number'] as int,
    );

Map<String, dynamic> _$EpisodeDtoToJson(EpisodeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'number': instance.episodeNumber,
    };
