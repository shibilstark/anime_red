part of 'anime_bloc.dart';

sealed class AnimeEvent extends Equatable {
  const AnimeEvent();

  @override
  List<Object> get props => [];
}

class AnimeGetInfo extends AnimeEvent {
  final String id;
  const AnimeGetInfo(this.id);
}
