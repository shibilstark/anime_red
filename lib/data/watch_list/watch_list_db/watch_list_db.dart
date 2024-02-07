import 'package:anime_red/data/watch_list/watch_list_entity/watch_list_entity.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchListDB {
  final watchListBox = Hive.openBox<WatchListEntity>("watchlist");

  Future<List<WatchListEntity>> getAll() async {
    final box = await watchListBox;
    final items = box.values.toList();
    await box.close();
    return items;
  }

  Future<void> putNewItem(WatchListEntity entity) async {
    final box = await watchListBox;
    await box.put(entity.id, entity);
    await box.close();
    return;
  }

  Future<void> removeAllFromWatchListType(String type) async {
    final box = await watchListBox;

    final keys = box.values
        .toList()
        .where((element) => element.type == type)
        .map((e) => e.id)
        .toList();

    await box.deleteAll(keys);
    await box.close();
    return;
  }

  Future<void> removeItem(String key) async {
    final box = await watchListBox;
    await box.delete(key);
    await box.close();
    return;
  }

  Future<void> resetAllWatchList() async {
    final box = await watchListBox;
    await box.clear();
    await box.close();
    return;
  }

  Future<bool> updateWatchListType(
      {required String key, required String type}) async {
    final box = await watchListBox;

    final old = box.get(key);

    if (old != null) {
      box.put(key, old.updateWatchListType(type));
      await box.close();
      return true;
    } else {
      await box.close();
      return false;
    }
  }
}
