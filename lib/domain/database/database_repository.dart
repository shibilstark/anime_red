import 'package:injectable/injectable.dart';

@injectable
abstract class AppDbRepository {
  Future<void> initializeDB();
}
