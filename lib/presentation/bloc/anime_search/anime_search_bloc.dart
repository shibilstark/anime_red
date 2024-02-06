import 'package:anime_red/domain/anime/anime_repository/anime_respository.dart';
import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/common_types/failures.dart';
import 'package:anime_red/domain/models/pagination_model.dart';
import 'package:anime_red/domain/models/search_result_model.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'anime_search_event.dart';
part 'anime_search_state.dart';

@injectable
class AnimeSearchBloc extends Bloc<AnimeSearchEvent, AnimeSearchState> {
  final AnimeRepository repository;
  AnimeSearchBloc(this.repository) : super(AnimeSearchInitial()) {
    on<AnimeSearchQuery>(_searchAnime);
    on<AnimeSearchAddNextPage>(_addNextPage);
  }

  _searchAnime(AnimeSearchQuery event, Emitter<AnimeSearchState> emit) async {
    emit(const AnimeSearchLoading());

    if (await haveInternetConnection()) {
      await repository.searchAnime(query: event.query.trim()).then((result) {
        result.fold((failure) {
          emit(
              AnimeSearchFailure(type: failure.type, message: failure.message));
        }, (model) {
          emit(AnimeSearchSuccess(
            searchResults: model,
          ));
        });
      });
    } else {
      const failure = InternetFailure();
      emit(AnimeSearchFailure(type: failure.type, message: failure.message));
    }
  }

  _addNextPage(
      AnimeSearchAddNextPage event, Emitter<AnimeSearchState> emit) async {
    final currentState = state;

    if (currentState is AnimeSearchSuccess &&
        currentState.searchResults.hasNextPage) {
      emit(
        AnimeSearchSuccess(
          searchResults: currentState.searchResults,
          isLoading: true,
        ),
      );
      if (await haveInternetConnection()) {
        await Future.delayed(const Duration(seconds: 1));

        final nextPage = currentState.searchResults.currentPage + 1;

        await repository
            .searchAnime(query: event.query.trim(), page: nextPage)
            .then((result) {
          result.fold((failure) {
            emit(
              AnimeSearchSuccess(
                searchResults: currentState.searchResults,
                anyError: failure,
              ),
            );
          }, (model) {
            final updatedPage = PaginationModel<SearchResultModel>(
              currentPage: model.currentPage,
              hasNextPage: model.hasNextPage,
              datas: List.from(
                  currentState.searchResults.datas..addAll(model.datas)),
            );

            emit(AnimeSearchSuccess(
              searchResults: updatedPage,
            ));
          });
        });
      } else {
        const failure = InternetFailure();
        emit(
          AnimeSearchSuccess(
            searchResults: currentState.searchResults,
            anyError: failure,
          ),
        );
      }
    }
  }
}
