// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultDto _$SearchResultDtoFromJson(Map<String, dynamic> json) =>
    SearchResultDto(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      subOrDub: json['subOrDub'] as String,
      releaseDate: json['releaseDate'] as String?,
    );

Map<String, dynamic> _$SearchResultDtoToJson(SearchResultDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'subOrDub': instance.subOrDub,
      'releaseDate': instance.releaseDate,
    };
