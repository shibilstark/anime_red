part of 'watch_history_bloc.dart';

sealed class WatchHistoryEvent extends Equatable {
  const WatchHistoryEvent();

  @override
  List<Object> get props => [];
}

class WatchHistoryGetAll extends WatchHistoryEvent {
  const WatchHistoryGetAll();
}

class WatchHistoryRemoveItem extends WatchHistoryEvent {
  final String id;
  const WatchHistoryRemoveItem(this.id);
}

class WatchHistoryClearAllHistory extends WatchHistoryEvent {
  const WatchHistoryClearAllHistory();
}

class WatchHistoryAddNewHistory extends WatchHistoryEvent {
  final WatchHistoryModel model;
  const WatchHistoryAddNewHistory(this.model);
}

class WatchHistorySyncAllData extends WatchHistoryEvent {
  const WatchHistorySyncAllData();
}
