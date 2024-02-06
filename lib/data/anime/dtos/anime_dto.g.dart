// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeDto _$AnimeDtoFromJson(Map<String, dynamic> json) => AnimeDto(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      url: json['url'] as String,
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String?,
      episodeCount: json['totalEpisodes'] as int,
      otherName: json['otherName'] as String?,
      status: json['status'] as String,
      subOrDub: json['subOrDub'] as String,
      type: json['type'] as String?,
      episodes: (json['episodes'] as List<dynamic>)
          .map((e) => EpisodeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      releaseDate: json['releaseDate'] as String?,
    );

Map<String, dynamic> _$AnimeDtoToJson(AnimeDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'subOrDub': instance.subOrDub,
      'type': instance.type,
      'description': instance.description,
      'status': instance.status,
      'genres': instance.genres,
      'url': instance.url,
      'otherName': instance.otherName,
      'totalEpisodes': instance.episodeCount,
      'episodes': instance.episodes,
      'releaseDate': instance.releaseDate,
    };
