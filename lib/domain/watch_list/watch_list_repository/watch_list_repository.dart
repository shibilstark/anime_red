import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/watch_list/watch_list_model/watch_list_model.dart';
import 'package:injectable/injectable.dart';

@injectable
abstract class WatchListRepository {
  const WatchListRepository();

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
