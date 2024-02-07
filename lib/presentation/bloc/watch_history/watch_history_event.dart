part of 'watch_history_bloc.dart';

sealed class WatchHistoryEvent extends Equatable {
  const WatchHistoryEvent();

  @override
  List<Object> get props => [];
}

class WatchHistoryGetAll extends WatchHistoryEvent {
  const WatchHistoryGetAll();
}

class WatchHistoryAddNewItem extends WatchHistoryEvent {
  final WatchHistoryModel model;
  const WatchHistoryAddNewItem(this.model);
}

class WatchHistoryRemoveItem extends WatchHistoryEvent {
  final String id;
  const WatchHistoryRemoveItem(this.id);
}

class WatchHistoryClearAllHistory extends WatchHistoryEvent {
  const WatchHistoryClearAllHistory();
}

class WatchHistoryUpdateStatus extends WatchHistoryEvent {
  final String id;
  final String newEpisodeId;
  final Duration newPosition;

  const WatchHistoryUpdateStatus({
    required this.id,
    required this.newEpisodeId,
    required this.newPosition,
  });
}
