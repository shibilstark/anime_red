import 'package:anime_red/domain/common_types/enums.dart';
import 'package:equatable/equatable.dart';

class WatchListModel extends Equatable {
  final String id;
  final String title;
  final String image;
  final String subOrDub;
  final String? description;
  final String type;
  final List<String> genres;
  final WatchListType watchListType;

  const WatchListModel({
    required this.id,
    required this.title,
    required this.image,
    required this.genres,
    required this.subOrDub,
    required this.type,
    required this.watchListType,
    this.description,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        genres,
        subOrDub,
        type,
        description,
        watchListType,
      ];

  WatchListModel updateWatchListType(WatchListType newType) {
    return WatchListModel(
      id: id,
      title: title,
      image: image,
      genres: genres,
      subOrDub: subOrDub,
      type: type,
      watchListType: newType,
      description: description,
    );
  }
}
