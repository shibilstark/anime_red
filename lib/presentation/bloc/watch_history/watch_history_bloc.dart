import 'package:anime_red/domain/watch_history/watch_history_model.dart/watch_history_model.dart';
import 'package:anime_red/domain/watch_history/watch_history_repository.dart/watch_history_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'watch_history_event.dart';
part 'watch_history_state.dart';

@injectable
class WatchHistoryBloc extends Bloc<WatchHistoryEvent, WatchHistoryState> {
  final WatchHistoryRepository repository;
  WatchHistoryBloc(this.repository)
      : super(WatchHistoryState(
            lastUpdated: DateTime.now(), watchHistory: const [])) {
    on<WatchHistoryGetAll>(_getAll);
    on<WatchHistoryRemoveItem>(_removeItem);
    on<WatchHistoryClearAllHistory>(_clearAllHistory);
    on<WatchHistorySyncAllData>(_syncAll);
  }

  _getAll(
    WatchHistoryGetAll event,
    Emitter<WatchHistoryState> emit,
  ) async {
    await _updateAllData(emit);
  }

  _syncAll(
    WatchHistorySyncAllData event,
    Emitter<WatchHistoryState> emit,
  ) async {
    if (state.lastUpdated.isBefore(state.watchHistory.first.lastUpdatedAt)) {
      await _updateAllData(emit);
    }
  }

  _removeItem(
    WatchHistoryRemoveItem event,
    Emitter<WatchHistoryState> emit,
  ) async {
    await repository.removeHistoryItem(event.id).then((_) async {
      await _updateAllData(emit);
    });
  }

  _clearAllHistory(
    WatchHistoryClearAllHistory event,
    Emitter<WatchHistoryState> emit,
  ) async {}

  _updateAllData(Emitter<WatchHistoryState> emit) async {
    await repository.getAll().then((allData) {
      emit(WatchHistoryState(
        watchHistory: allData
          ..sort((a, b) => a.lastUpdatedAt.compareTo(b.lastUpdatedAt)),
        lastUpdated: DateTime.now(),
      ));
    });
  }
}
