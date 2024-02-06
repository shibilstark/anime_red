part of 'watch_list_bloc.dart';

class WatchListState extends Equatable {
  final List<WatchListModel> watchList;
  const WatchListState(this.watchList);

  @override
  List<Object> get props => [watchList];
}
