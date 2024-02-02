import 'package:equatable/equatable.dart';

class TopAiringModel extends Equatable {
  final String id;
  final String title;
  final String image;
  final List<String> genres;
  final String url;

  const TopAiringModel({
    required this.id,
    required this.title,
    required this.image,
    required this.url,
    required this.genres,
  });

  @override
  List<Object> get props => [
        id,
        title,
        image,
        url,
        genres,
      ];
}
