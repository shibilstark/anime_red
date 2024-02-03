// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_airing_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopAiringDto _$TopAiringDtoFromJson(Map<String, dynamic> json) => TopAiringDto(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      url: json['url'] as String,
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TopAiringDtoToJson(TopAiringDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'genres': instance.genres,
      'url': instance.url,
    };
