part of 'anime_search_bloc.dart';

sealed class AnimeSearchState extends Equatable {
  const AnimeSearchState();

  @override
  List<Object?> get props => [];
}

final class AnimeSearchInitial extends AnimeSearchState {}

final class AnimeSearchLoading extends AnimeSearchState {
  const AnimeSearchLoading();
}

final class AnimeSearchFailure extends AnimeSearchState {
  final FailureType type;
  final String message;
  const AnimeSearchFailure({
    required this.type,
    required this.message,
  });

  @override
  List<Object?> get props => [type, message];
}

final class AnimeSearchSuccess extends AnimeSearchState {
  final PaginationModel<SearchResultModel> searchResults;
  final AppFailure? anyError;
  final bool isLoading;

  const AnimeSearchSuccess({
    required this.searchResults,
    this.anyError,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        searchResults,
        anyError,
        isLoading,
      ];
}
