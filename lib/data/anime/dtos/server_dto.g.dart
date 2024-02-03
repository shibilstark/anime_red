// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerDto _$ServerDtoFromJson(Map<String, dynamic> json) => ServerDto(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$ServerDtoToJson(ServerDto instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
