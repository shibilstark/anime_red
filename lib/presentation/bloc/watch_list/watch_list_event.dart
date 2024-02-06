part of 'watch_list_bloc.dart';

sealed class WatchListEvent extends Equatable {
  const WatchListEvent();

  @override
  List<Object> get props => [];
}

class WatchListGetAll extends WatchListEvent {
  const WatchListGetAll();
}

class WatchListAddNew extends WatchListEvent {
  final WatchListModel model;
  const WatchListAddNew(this.model);
}

class WatchListUpdateType extends WatchListEvent {
  final String id;
  final WatchListType type;
  const WatchListUpdateType({
    required this.id,
    required this.type,
  });
}

class WatchListRemoveItem extends WatchListEvent {
  final String id;
  const WatchListRemoveItem(this.id);
}

class WatchListReselAll extends WatchListEvent {
  const WatchListReselAll();
}

class WatchListRemoveAllByType extends WatchListEvent {
  final WatchListType type;
  const WatchListRemoveAllByType(this.type);
}
