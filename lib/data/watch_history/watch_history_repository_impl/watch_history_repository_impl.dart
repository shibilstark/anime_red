import 'package:injectable/injectable.dart';

import '../../../domain/watch_history/watch_history_model.dart/watch_history_model.dart';
import '../../../domain/watch_history/watch_history_repository.dart/watch_history_repository.dart';
import '../../../injector/injector.dart';
import '../watch_history_db/watch_history_db.dart';
import '../watch_history_entity/watch_history_entity.dart';

@LazySingleton(as: WatchHistoryRepository)
class WatchHistoryRepositoryImpl implements WatchHistoryRepository {
  WatchHistoryDB get _db => getIt<WatchHistoryDB>();

  @override
  Future<void> addNewHistory(WatchHistoryModel model) async {
    return await _db.addNewHistory(WatchHistoryEntity.fromModel(model));
  }

  @override
  Future<void> clearAllWatchHistory() async {
    return await _db.clearAllWatchHistory();
  }

  @override
  Future<List<WatchHistoryModel>> getAll() async {
    return (await _db.getAll()).map((e) => e.toModel()).toList();
  }

  @override
  Future<void> removeHistoryItem(String id) async {
    return await _db.removeHistoryItem(id);
  }

  @override
  Future<void> updateStatus({
    required String id,
    required String newEpisodeId,
    required Duration newPosition,
    required Duration newTotalLength,
  }) async {
    return await _db.updateStatus(
      id: id,
      episodeId: newEpisodeId,
      newPosition: newPosition,
      newTotalLength: newTotalLength,
    );
  }

  @override
  Future<Duration?> getDurationFromEpisode({
    required String id,
    required String episodeId,
  }) async =>
      _db.getDurationFromEpisode(id: id, episodeId: episodeId);

  @override
  Future<WatchHistoryModel?> getHistoryById(String id) async {
    return (await _db.getHistoryById(id))?.toModel();
  }
}
