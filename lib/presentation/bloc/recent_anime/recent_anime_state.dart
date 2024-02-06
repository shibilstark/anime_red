part of 'recent_anime_bloc.dart';

sealed class RecentAnimeState extends Equatable {
  const RecentAnimeState();

  @override
  List<Object?> get props => [];
}

final class RecentAnimeInitial extends RecentAnimeState {}

final class RecentAnimeLoading extends RecentAnimeState {
  const RecentAnimeLoading();
}

final class RecentAnimeFailure extends RecentAnimeState {
  final FailureType type;
  final String message;
  const RecentAnimeFailure({
    required this.type,
    required this.message,
  });

  @override
  List<Object?> get props => [type, message];
}

final class RecentAnimeSuccess extends RecentAnimeState {
  final PaginationModel<RecentEpisodeModel> recentAnimes;
  final AppFailure? anyError;
  final bool isLoading;

  const RecentAnimeSuccess({
    required this.recentAnimes,
    this.anyError,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        recentAnimes,
        anyError,
        isLoading,
      ];
}
