part of 'recent_anime_bloc.dart';

sealed class RecentAnimeEvent extends Equatable {
  const RecentAnimeEvent();

  @override
  List<Object> get props => [];
}

class RecentAnimeLoadData extends RecentAnimeEvent {
  const RecentAnimeLoadData();
}

class RecentAnimeAddNextPage extends RecentAnimeEvent {
  const RecentAnimeAddNextPage();
}
