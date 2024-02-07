part of 'watch_history_bloc.dart';

class WatchHistoryState extends Equatable {
  final List<WatchHistoryModel> watchHistory;
  final bool notifier;
  const WatchHistoryState(this.watchHistory, {this.notifier = true});

  @override
  List<Object> get props => [
        watchHistory,
        notifier,
      ];
}
