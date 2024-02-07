import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/watch_list/watch_list_model/watch_list_model.dart';
import 'package:anime_red/domain/watch_list/watch_list_repository/watch_list_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'watch_list_event.dart';
part 'watch_list_state.dart';

@injectable
class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  final WatchListRepository repository;

  WatchListBloc(this.repository)
      : super(const WatchListState(
          [],
          notifier: false,
        )) {
    on<WatchListGetAll>(_getAllWatchList);
    on<WatchListAddNew>(_addNewWatchList);
    on<WatchListUpdateType>(_updateWatchListType);
    on<WatchListRemoveItem>(_removeItemFromList);
    on<WatchListReselAll>(_resetWatchList);
    on<WatchListRemoveAllByType>(_removeAllByType);
  }

  _getAllWatchList(WatchListGetAll event, Emitter<WatchListState> emit) async {
    await __updateAll(emit);
  }

  _addNewWatchList(WatchListAddNew event, Emitter<WatchListState> emit) async {
    await repository.putNewItem(event.model).then((_) async {
      await __updateAll(emit);
    });
  }

  _updateWatchListType(
      WatchListUpdateType event, Emitter<WatchListState> emit) async {
    await repository
        .updateWatchListType(key: event.id, type: event.type)
        .then((_) async {
      await __updateAll(emit);
    });
  }

  _removeItemFromList(
      WatchListRemoveItem event, Emitter<WatchListState> emit) async {
    await repository.removeItem(event.id).then((_) async {
      await __updateAll(emit);
    });
  }

  _resetWatchList(WatchListReselAll event, Emitter<WatchListState> emit) async {
    await repository.resetAllWatchList().then((_) async {
      await __updateAll(emit);
    });
  }

  _removeAllByType(
      WatchListRemoveAllByType event, Emitter<WatchListState> emit) async {
    await repository.removeAllFromWatchListType(event.type).then((_) async {
      await __updateAll(emit);
    });
  }

  __updateAll(Emitter<WatchListState> emit) async {
    await repository.getAll().then((watchListItems) {
      emit(WatchListState(
        List.from(watchListItems),
        notifier: !state.notifier,
      ));
    });
  }
}
