// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationDto<T> _$PaginationDtoFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginationDto<T>(
      currentPage: json['currentPage'] as int,
      hasNextPage: json['hasNextPage'] as bool,
      datas: (json['datas'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$PaginationDtoToJson<T>(
  PaginationDto<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'hasNextPage': instance.hasNextPage,
      'datas': instance.datas.map(toJsonT).toList(),
    };
