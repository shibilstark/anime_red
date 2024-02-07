import 'package:hive/hive.dart';

import '../watch_history_entity/watch_history_entity.dart';

class WatchHistoryDB {
  final _watchHistoryBox = Hive.openBox<WatchHistoryEntity>("watch_history");

  Future<void> addNewHistory(WatchHistoryEntity entity) async {
    final box = await _watchHistoryBox;
    await box.put(entity.id, entity);
    await box.close();
    return;
  }

  Future<List<WatchHistoryEntity>> getAll() async {
    final box = await _watchHistoryBox;
    final items = box.values.toList();
    await box.close();
    return items;
  }

  Future<void> removeHistoryItem(String id) async {
    final box = await _watchHistoryBox;
    await box.delete(id);
    await box.close();
    return;
  }

  Future<void> clearAllWatchHistory() async {
    final box = await _watchHistoryBox;
    await box.clear();
    await box.close();
    return;
  }

  Future<void> updateStatus({
    required String id,
    required String episodeId,
    required Duration newPosition,
  }) async {
    final box = await _watchHistoryBox;

    final old = box.get(id);

    if (old != null) {
      box.put(id, old.updateStatus(newEpisodeId: id, newPosition: newPosition));
      await box.close();
    }

    await box.close();
    return;
  }
}
