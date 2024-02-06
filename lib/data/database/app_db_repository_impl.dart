import 'package:anime_red/data/database/app_db.dart';
import 'package:injectable/injectable.dart';

import '../../domain/database/database_repository.dart';

@LazySingleton(as: AppDbRepository)
class AppDbRepositoryImplementation implements AppDbRepository {
  @override
  Future<void> initializeDB() async {
    await AppDataBase.initDatabase();
    return;
  }
}
