part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadData extends HomeEvent {
  const HomeLoadData();
}

class HomeAddNextPage extends HomeEvent {
  const HomeAddNextPage();
}
