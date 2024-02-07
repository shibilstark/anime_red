import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../watch_history_entity/watch_history_entity.dart';

@injectable
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
    // await box.close();
    return items;
  }

  Future<WatchHistoryEntity?> getHistoryById(String id) async {
    final box = await _watchHistoryBox;
    final item = box.get(id);

    await box.close();
    return item;
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
    required Duration newTotalLength,
  }) async {
    final box = await _watchHistoryBox;

    final old = box.get(id);

    if (old != null) {
      await box.put(
          id,
          old.updateStatus(
              newEpisodeId: episodeId,
              newPosition: newPosition,
              newTotalLength: newTotalLength));

      await box.close();
    }

    await box.close();
    return;
  }

  Future<Duration?> getDurationFromEpisode({
    required String id,
    required String episodeId,
  }) async {
    final box = await _watchHistoryBox;
    final entity = box.get(id);

    if (entity == null) {
      return null;
    }

    if (entity.episodeId != episodeId) {
      return null;
    }
    final duration = entity.currentPosition;

    await box.close();

    log(duration.toString());

    return duration;
  }
}
