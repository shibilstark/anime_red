part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeFailure extends HomeState {
  final FailureType type;
  final String message;
  const HomeFailure({
    required this.type,
    required this.message,
  });

  @override
  List<Object?> get props => [type, message];
}

final class HomeSuccess extends HomeState {
  final PaginationModel<TopAiringModel> topAnimes;
  final AppFailure? anyError;

  const HomeSuccess({
    required this.topAnimes,
    this.anyError,
  });

  @override
  List<Object?> get props => [
        topAnimes,
        anyError,
      ];
}
