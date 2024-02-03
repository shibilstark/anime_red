// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_episode_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentEpisodeDto _$RecentEpisodeDtoFromJson(Map<String, dynamic> json) =>
    RecentEpisodeDto(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      url: json['url'] as String,
      episodeNumber: json['episodeNumber'] as int,
      eposodeId: json['episodeId'] as String,
    );

Map<String, dynamic> _$RecentEpisodeDtoToJson(RecentEpisodeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'episodeId': instance.eposodeId,
      'url': instance.url,
      'episodeNumber': instance.episodeNumber,
    };
