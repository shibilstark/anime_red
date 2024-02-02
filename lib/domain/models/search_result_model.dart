import 'package:equatable/equatable.dart';

class SearchResultModel extends Equatable {
  final String id;
  final String title;
  final String image;
  final String subOrDub;
  final String? releaseDate;

  const SearchResultModel({
    required this.id,
    required this.title,
    required this.image,
    required this.subOrDub,
    required this.releaseDate,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        subOrDub,
        releaseDate,
      ];
}
