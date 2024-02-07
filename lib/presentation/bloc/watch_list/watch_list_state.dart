part of 'watch_list_bloc.dart';

class WatchListState extends Equatable {
  final List<WatchListModel> watchList;
  final bool notifier;
  const WatchListState(this.watchList, {this.notifier = true});

  @override
  List<Object> get props => [
        watchList,
        notifier,
      ];
}
