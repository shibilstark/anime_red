part of 'anime_search_bloc.dart';

sealed class AnimeSearchEvent extends Equatable {
  const AnimeSearchEvent();

  @override
  List<Object> get props => [];
}

class AnimeSearchQuery extends AnimeSearchEvent {
  final String query;
  const AnimeSearchQuery(this.query);
}

class AnimeSearchAddNextPage extends AnimeSearchEvent {
  final String query;
  const AnimeSearchAddNextPage(this.query);
}
