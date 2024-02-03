// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'pagination_dto.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationDto<T> {
  final int currentPage;
  final bool hasNextPage;
  final List<T> datas;

  const PaginationDto({
    required this.currentPage,
    required this.hasNextPage,
    required this.datas,
  });

  factory PaginationDto.fromMap(
      Map<String, dynamic> map, Function fromJsonModel) {
    final items = map['results'] as List;
    return PaginationDto<T>(
        currentPage: int.parse((map['currentPage'] as String)),
        hasNextPage: map['hasNextPage'] as bool,
        datas: List<T>.from(
            items.map((itemsJson) => fromJsonModel(itemsJson)).toList()));
  }

  factory PaginationDto.fromJson(String source, Function fromJsonModel) =>
      PaginationDto.fromMap(
        json.decode(source) as Map<String, dynamic>,
        fromJsonModel,
      );
}
