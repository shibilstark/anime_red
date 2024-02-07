import 'package:injectable/injectable.dart';

import '../watch_history_model.dart/watch_history_model.dart';

@injectable
abstract class WatchHistoryRepository {
  Future<void> addNewHistory(WatchHistoryModel model);

  Future<List<WatchHistoryModel>> getAll();

  Future<void> removeHistoryItem(String id);

  Future<void> clearAllWatchHistory();

  Future<void> updateStatus({
    required String id,
    required String newEpisodeId,
    required Duration newPosition,
  });
}
