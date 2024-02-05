part of 'anime_bloc.dart';

sealed class AnimeState extends Equatable {
  const AnimeState();

  @override
  List<Object?> get props => [];
}

final class AnimeInitial extends AnimeState {}

final class AnimeLoading extends AnimeState {
  const AnimeLoading();
}

final class AnimeFailure extends AnimeState {
  final FailureType type;
  final String message;
  const AnimeFailure({
    required this.type,
    required this.message,
  });

  @override
  List<Object?> get props => [type, message];
}

final class AnimeSuccess extends AnimeState {
  final AnimeModel anime;

  const AnimeSuccess({
    required this.anime,
  });

  @override
  List<Object?> get props => [
        anime,
      ];
}
