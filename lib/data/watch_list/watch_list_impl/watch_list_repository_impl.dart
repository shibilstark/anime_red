import 'package:anime_red/data/watch_list/watch_list_db/watch_list_db.dart';
import 'package:anime_red/data/watch_list/watch_list_entity/watch_list_entity.dart';
import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/watch_list/watch_list_model/watch_list_model.dart';
import 'package:anime_red/domain/watch_list/watch_list_repository/watch_list_repository.dart';
import 'package:anime_red/injector/injector.dart';

class WatchListRepositoryImpl implements WatchListRepository {
  @override
  WatchListDB get db => getIt<WatchListDB>();

  @override
  Future<void> putNewItem(WatchListModel model) async {
    return await db.putNewItem(WatchListEntity.fromModel(model));
  }

  @override
  Future<void> removeAllFromWatchListType(WatchListType type) async {
    return await db.removeAllFromWatchListType(type.name);
  }

  @override
  Future<void> removeItem(String key) async {
    return await db.removeItem(key);
  }

  @override
  Future<void> resetAllWatchList() async {
    return await db.resetAllWatchList();
  }

  @override
  Future<bool> updateWatchListType(
      {required String key, required WatchListType type}) async {
    return await db.updateWatchListType(key: key, type: type.name);
  }

  @override
  Future<List<WatchListModel>> getAll() async {
    return (await db.getAll()).map((e) => e.toModel()).toList();
  }
}
