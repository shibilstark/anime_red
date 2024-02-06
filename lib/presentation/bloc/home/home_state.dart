part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

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
  final bool isLoading;

  const HomeSuccess({
    required this.topAnimes,
    this.anyError,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        topAnimes,
        anyError,
        isLoading,
      ];
}
