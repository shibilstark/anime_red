import 'package:anime_red/domain/anime/anime_repository/anime_respository.dart';
import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/common_types/failures.dart';
import 'package:anime_red/domain/models/anime_model.dart';
import 'package:anime_red/domain/models/episode_model.dart';
import 'package:anime_red/domain/models/start_end_model.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quiver/iterables.dart' as iterableQuiver;

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
          emit(
            AnimeSuccess(
              anime: model,
              startEndList: List.from(_generateStartEndList(model.episodes)),
            ),
          );
        });
      });
    } else {
      const failure = InternetFailure();
      emit(AnimeFailure(type: failure.type, message: failure.message));
    }
  }

  List<StartEndModel> _generateStartEndList(List<EpisodeModel> episodes) {
    if (episodes.isEmpty) {
      return [];
    } else {
      if (episodes.length <= 100) {
        return [
          StartEndModel(
            end: episodes.length - 1,
            start: 0,
          )
        ];
      } else {
        List<StartEndModel> organizedIndexes = [];
        final partitionedPairs =
            iterableQuiver.partition(episodes, 100).toList();

        for (final element in partitionedPairs) {
          final start = episodes.indexOf(element.first);
          final end = episodes.indexOf(element.last);
          organizedIndexes.add(StartEndModel(end: end, start: start));
        }

        organizedIndexes.sort((a, b) => a.start.compareTo(b.start));

        return organizedIndexes;
      }
    }
  }
}
