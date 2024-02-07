part of 'watch_history_bloc.dart';

class WatchHistoryState extends Equatable {
  final List<WatchHistoryModel> watchHistory;
  final DateTime lastUpdated;
  const WatchHistoryState(
      {required this.watchHistory, required this.lastUpdated});

  @override
  List<Object> get props => [
        watchHistory,
        lastUpdated,
      ];
}
