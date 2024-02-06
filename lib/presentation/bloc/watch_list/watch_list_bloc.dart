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

  WatchListBloc(this.repository) : super(const WatchListState([])) {
    on<WatchListGetAll>(_getAllWatchList);
    on<WatchListAddNew>(_addNewWatchList);
    on<WatchListUpdateType>(_updateWatchListType);
    on<WatchListRemoveItem>(_removeItemFromList);
    on<WatchListReselAll>(_resetWatchList);
    on<WatchListAddNew>(_addNewWatchList);
    on<WatchListRemoveAllByType>(_removeAllByType);
  }

  _getAllWatchList(WatchListGetAll event, Emitter<WatchListState> emit) async {
    final watchListItems = await repository.getAll();
    emit(WatchListState(List.from(watchListItems)));
  }

  _addNewWatchList(WatchListAddNew event, Emitter<WatchListState> emit) async {
    await repository.putNewItem(event.model).then((_) {
      emit(WatchListState(List.from(state.watchList..add(event.model))));
    });
  }

  _updateWatchListType(
      WatchListUpdateType event, Emitter<WatchListState> emit) async {
    await repository
        .updateWatchListType(key: event.id, type: event.type)
        .then((value) {
      if (value == true) {
        emit(
          WatchListState(
            List.from(
              state.watchList
                ..firstWhere((element) => element.id == event.id)
                    .updateWatchListType(event.type),
            ),
          ),
        );
      }
    });
  }

  _removeItemFromList(
      WatchListRemoveItem event, Emitter<WatchListState> emit) async {
    await repository.removeItem(event.id).then((_) {
      emit(
        WatchListState(
          List.from(
            state.watchList..removeWhere((element) => element.id == event.id),
          ),
        ),
      );
    });
  }

  _resetWatchList(WatchListReselAll event, Emitter<WatchListState> emit) async {
    await repository.resetAllWatchList().then((_) {
      emit(
        WatchListState(List.from([])),
      );
    });
  }

  _removeAllByType(
      WatchListRemoveAllByType event, Emitter<WatchListState> emit) async {
    await repository.removeAllFromWatchListType(event.type).then((_) {
      emit(
        WatchListState(
          List.from(
            state.watchList
              ..removeWhere((element) => element.watchListType == event.type),
          ),
        ),
      );
    });
  }
}
