import 'package:anime_red/domain/anime/anime_repository/anime_respository.dart';
import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/common_types/failures.dart';
import 'package:anime_red/domain/models/pagination_model.dart';
import 'package:anime_red/domain/models/top_airing_model.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AnimeRepository repository;
  HomeBloc(this.repository) : super(HomeInitial()) {
    on<HomeLoadData>(_loadHome);
    on<HomeAddNextPage>(_addNextPage);
  }

  _loadHome(HomeLoadData event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());

    if (await haveInternetConnection()) {
      await repository.getTopAiringAnime().then((result) {
        result.fold((failure) {
          emit(HomeFailure(type: failure.type, message: failure.message));
        }, (model) {
          emit(HomeSuccess(
            topAnimes: model,
          ));
        });
      });
    } else {
      const failure = InternetFailure();
      emit(HomeFailure(type: failure.type, message: failure.message));
    }
  }

  _addNextPage(HomeAddNextPage event, Emitter<HomeState> emit) async {
    final currentState = state;

    if (currentState is HomeSuccess && currentState.topAnimes.hasNextPage) {
      if (await haveInternetConnection()) {
        emit(
          HomeSuccess(
            topAnimes: currentState.topAnimes,
            isLoading: true,
          ),
        );

        final nextPage = currentState.topAnimes.currentPage + 1;

        await repository.getTopAiringAnime(page: nextPage).then((result) {
          result.fold((failure) {
            emit(
              HomeSuccess(
                topAnimes: currentState.topAnimes,
                anyError: failure,
              ),
            );
          }, (model) {
            final updatedPage = PaginationModel<TopAiringModel>(
              currentPage: model.currentPage,
              hasNextPage: model.hasNextPage,
              datas:
                  List.from(currentState.topAnimes.datas..addAll(model.datas)),
            );

            emit(HomeSuccess(
              topAnimes: updatedPage,
            ));
          });
        });
      } else {
        const failure = InternetFailure();
        emit(
          HomeSuccess(
            topAnimes: currentState.topAnimes,
            anyError: failure,
          ),
        );
      }
    }
  }
}
