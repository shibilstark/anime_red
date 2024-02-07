import 'package:anime_red/domain/watch_history/watch_history_model.dart/watch_history_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'watch_history_event.dart';
part 'watch_history_state.dart';

class WatchHistoryBloc extends Bloc<WatchHistoryEvent, WatchHistoryState> {
  WatchHistoryBloc() : super(const WatchHistoryState([])) {
    on<WatchHistoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
