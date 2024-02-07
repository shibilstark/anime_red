import 'package:anime_red/data/database/custom_adapters.dart';
import 'package:anime_red/data/watch_history/watch_history_entity/watch_history_entity.dart';
import 'package:anime_red/data/watch_list/watch_list_entity/watch_list_entity.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class AppDataBase {
  static Future<void> initDatabase() async {
    final documentDir = await getApplicationDocumentsDirectory();
    Hive.init(documentDir.path);

    _registerAdapters();
    return;
  }

  static _registerAdapters() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(WatchListEntityAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(WatchHistoryEntityAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(DurationAdapter());
    }
  }
}
