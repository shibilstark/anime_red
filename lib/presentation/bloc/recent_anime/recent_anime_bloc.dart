import 'package:anime_red/domain/anime/anime_repository/anime_respository.dart';
import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/common_types/failures.dart';
import 'package:anime_red/domain/models/pagination_model.dart';
import 'package:anime_red/domain/models/recent_episode_model.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'recent_anime_event.dart';
part 'recent_anime_state.dart';

@injectable
class RecentAnimeBloc extends Bloc<RecentAnimeEvent, RecentAnimeState> {
  final AnimeRepository repository;
  RecentAnimeBloc(this.repository) : super(RecentAnimeInitial()) {
    on<RecentAnimeLoadData>(_loadRecentAnime);
    on<RecentAnimeAddNextPage>(_addNextPage);
  }

  _loadRecentAnime(
      RecentAnimeLoadData event, Emitter<RecentAnimeState> emit) async {
    emit(const RecentAnimeLoading());

    if (await haveInternetConnection()) {
      await repository.getRecentReleases().then((result) {
        result.fold((failure) {
          emit(
              RecentAnimeFailure(type: failure.type, message: failure.message));
        }, (model) {
          emit(RecentAnimeSuccess(
            recentAnimes: model,
          ));
        });
      });
    } else {
      const failure = InternetFailure();
      emit(RecentAnimeFailure(type: failure.type, message: failure.message));
    }
  }

  _addNextPage(
      RecentAnimeAddNextPage event, Emitter<RecentAnimeState> emit) async {
    final currentState = state;

    if (currentState is RecentAnimeSuccess &&
        currentState.recentAnimes.hasNextPage) {
      if (await haveInternetConnection()) {
        await Future.delayed(const Duration(seconds: 2));
        emit(
          RecentAnimeSuccess(
            recentAnimes: currentState.recentAnimes,
            isLoading: true,
          ),
        );
        final nextPage = currentState.recentAnimes.currentPage + 1;

        await repository.getRecentReleases(page: nextPage).then((result) {
          result.fold((failure) {
            emit(
              RecentAnimeSuccess(
                recentAnimes: currentState.recentAnimes,
                anyError: failure,
              ),
            );
          }, (model) {
            final updatedPage = PaginationModel<RecentEpisodeModel>(
              currentPage: model.currentPage,
              hasNextPage: model.hasNextPage,
              datas: List.from(
                  currentState.recentAnimes.datas..addAll(model.datas)),
            );

            emit(RecentAnimeSuccess(
              recentAnimes: updatedPage,
            ));
          });
        });
      } else {
        const failure = InternetFailure();
        emit(
          RecentAnimeSuccess(
            recentAnimes: currentState.recentAnimes,
            anyError: failure,
          ),
        );
      }
    }
  }
}
