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
  final PaginationModel<RecentEpisodeModel> topAnimes;
  final AppFailure? anyError;

  const RecentAnimeSuccess({
    required this.topAnimes,
    this.anyError,
  });

  @override
  List<Object?> get props => [
        topAnimes,
        anyError,
      ];
}
