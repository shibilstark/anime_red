import 'package:anime_red/domain/anime/anime_repository/anime_respository.dart';
import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/common_types/failures.dart';
import 'package:anime_red/domain/models/anime_model.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'anime_event.dart';
part 'anime_state.dart';

@injectable
class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  final AnimeRepository repository;

  AnimeBloc(this.repository) : super(AnimeInitial()) {
    on<AnimeGetInfo>(_getAnimeInfoAndEpisodes);
  }

  _getAnimeInfoAndEpisodes(AnimeGetInfo event, Emitter<AnimeState> emit) async {
    emit(const AnimeLoading());

    if (await haveInternetConnection()) {
      await repository.getAnimeInfo(id: event.id).then((result) {
        result.fold((failure) {
          emit(AnimeFailure(type: failure.type, message: failure.message));
        }, (model) {
          emit(AnimeSuccess(
            anime: model,
          ));
        });
      });
    } else {
      const failure = InternetFailure();
      emit(AnimeFailure(type: failure.type, message: failure.message));
    }
  }
}
