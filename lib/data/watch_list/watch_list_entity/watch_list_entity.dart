import 'package:anime_red/domain/watch_list/watch_list_model/watch_list_model.dart';
import 'package:hive/hive.dart';

part 'watch_list_entity.g.dart';

@HiveType(typeId: 0)
class WatchListEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String subOrDub;
  @HiveField(4)
  final String? description;
  @HiveField(5)
  final String type;
  @HiveField(6)
  final List<String> genres;
  @HiveField(7)
  final String watchListType;

  const WatchListEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.genres,
    required this.subOrDub,
    required this.type,
    required this.watchListType,
    this.description,
  });

  WatchListModel toModel() {
    return WatchListModel(
      watchListType: WatchListType.values.byName(watchListType),
      id: id,
      description: description,
      title: title,
      image: image,
      genres: genres,
      subOrDub: subOrDub,
      type: type,
    );
  }

  WatchListEntity updateWatchListType(String watchListType) {
    return WatchListEntity(
      watchListType: watchListType,
      id: id,
      description: description,
      title: title,
      image: image,
      genres: genres,
      subOrDub: subOrDub,
      type: type,
    );
  }

  factory WatchListEntity.fromModel(WatchListModel model) {
    return WatchListEntity(
        id: model.id,
        title: model.title,
        image: model.image,
        genres: model.genres,
        subOrDub: model.subOrDub,
        type: model.type,
        watchListType: model.watchListType.name,
        description: model.description);
  }
}
