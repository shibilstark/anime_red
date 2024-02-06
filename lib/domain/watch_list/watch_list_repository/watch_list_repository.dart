import 'package:anime_red/data/watch_list/watch_list_db/watch_list_db.dart';
import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/watch_list/watch_list_model/watch_list_model.dart';
import 'package:injectable/injectable.dart';

@injectable
abstract class WatchListRepository {
  final WatchListDB db;
  const WatchListRepository(this.db);

  Future<void> putNewItem(WatchListModel model);

  Future<bool> updateWatchListType({
    required String key,
    required WatchListType type,
  });

  Future<void> removeItem(String key);

  Future<void> resetAllWatchList();

  Future<void> removeAllFromWatchListType(
    WatchListType type,
  );
  Future<List<WatchListModel>> getAll();
}
