import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class AppDataBase {
  static Future<void> initDatabase() async {
    final documentDir = await getApplicationDocumentsDirectory();
    Hive.init(documentDir.path);
    return;
  }
}
