import 'package:anime_red/domain/anime/anime_repository/anime_respository.dart';
import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/common_types/failures.dart';
import 'package:anime_red/domain/common_types/generic_types.dart';
import 'package:anime_red/domain/models/anime_model.dart';
import 'package:anime_red/domain/models/anime_player_data_model.dart';
import 'package:anime_red/domain/models/anime_streaminglink_model.dart';
import 'package:anime_red/domain/models/episode_model.dart';
import 'package:anime_red/domain/models/server_model.dart';
import 'package:anime_red/domain/models/start_end_model.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quiver/iterables.dart' as iterable_quiver;

part 'anime_event.dart';
part 'anime_state.dart';

@injectable
class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  final AnimeRepository repository;

  AnimeBloc(this.repository) : super(AnimeInitial()) {
    on<AnimeGetInfo>(_getAnimeInfoAndEpisodes);
    on<AnimeGetEpisodeLink>(_getEpisodeLinks);
    on<AnimeChangeStreamingServer>(_changeStreamingServer);
    on<AnimeChangeStreamingQuality>(_changeStreamingQuality);
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

  _changeStreamingServer(
    AnimeChangeStreamingServer event,
    Emitter<AnimeState> emit,
  ) async {
    final currentState = state;

    if (currentState is AnimeSuccess) {
      if (currentState.playerData != null) {
        await currentState.playerData!.fold((failure) async => null,
            (playerData) async {
          await repository
              .getStreamingLinks(
                  episodeId: event.episodeId, server: event.server)
              .then(
            (result) {
              result.fold((failure) {
                emit(
                  AnimeSuccess(
                    anime: currentState.anime,
                    startEndList: List.from(
                        _generateStartEndList(currentState.anime.episodes)),
                    playerData: Left(failure),
                  ),
                );
              }, (streamingLinks) {
                emit(
                  AnimeSuccess(
                    anime: currentState.anime,
                    startEndList: List.from(
                        _generateStartEndList(currentState.anime.episodes)),
                    playerData: Right(
                      AnimePlayerDataModel(
                        currentLink:
                            _getStreamingLinkByHierarchy(streamingLinks),
                        currentServer: playerData.servers.firstWhere(
                            (element) => element.name == event.server),
                        servers: playerData.servers,
                        streamingLinks: streamingLinks,
                      ),
                    ),
                  ),
                );
              });
            },
          );
        });
      }
    }
  }

  _changeStreamingQuality(
    AnimeChangeStreamingQuality event,
    Emitter<AnimeState> emit,
  ) async {
    final currentState = state;

    if (currentState is AnimeSuccess) {
      if (currentState.playerData != null) {
        currentState.playerData!.fold(
          (failure) => null,
          (playerData) {
            emit(AnimeSuccess(
              anime: currentState.anime,
              startEndList:
                  List.from(_generateStartEndList(currentState.anime.episodes)),
              playerData: Right(
                AnimePlayerDataModel(
                  currentLink: playerData.streamingLinks.sources.firstWhere(
                    (element) => element.quality == event.quality,
                  ),
                  currentServer: playerData.currentServer,
                  servers: playerData.servers,
                  streamingLinks: playerData.streamingLinks,
                ),
              ),
            ));
          },
        );
      }
    }
  }

  _getEpisodeLinks(AnimeGetEpisodeLink event, Emitter<AnimeState> emit) async {
    emit(const AnimeLoading());

    final currentState = state;

    if (currentState is AnimeSuccess) {
      if (await haveInternetConnection()) {
        await repository
            .getAvailableServers(episodeId: event.episodeId)
            .then((result) async {
          await result.fold((failure) async {
            emit(
              AnimeSuccess(
                anime: currentState.anime,
                startEndList: List.from(
                    _generateStartEndList(currentState.anime.episodes)),
                playerData: Left(failure),
              ),
            );
          }, (availableServers) async {
            late final ServerModel selectedServer;

            try {
              selectedServer = availableServers.firstWhere(
                  (server) => server.name == AnimeServerName.gogocdn);
            } catch (e) {
              selectedServer = availableServers.first;
            }

            await repository
                .getStreamingLinks(
                    episodeId: event.episodeId, server: selectedServer.name)
                .then((result) {
              result.fold((failure) {
                emit(
                  AnimeSuccess(
                    anime: currentState.anime,
                    startEndList: List.from(
                        _generateStartEndList(currentState.anime.episodes)),
                    playerData: Left(failure),
                  ),
                );
              }, (streamingLinks) {
                emit(
                  AnimeSuccess(
                    anime: currentState.anime,
                    startEndList: List.from(
                        _generateStartEndList(currentState.anime.episodes)),
                    playerData: Right(
                      AnimePlayerDataModel(
                        currentLink:
                            _getStreamingLinkByHierarchy(streamingLinks),
                        currentServer: selectedServer,
                        servers: availableServers,
                        streamingLinks: streamingLinks,
                      ),
                    ),
                  ),
                );
              });
            });
          });
        });
      } else {
        const failure = InternetFailure();
        emit(
          AnimeSuccess(
            anime: currentState.anime,
            startEndList:
                List.from(_generateStartEndList(currentState.anime.episodes)),
            playerData: const Left(failure),
          ),
        );
      }
    }
  }

  StreamingSourcesModel _getStreamingLinkByHierarchy(
      AnimeStreamingLinkModel model) {
    if (model.sources
        .any((element) => element.quality == StreamingQuality.quality1080p)) {
      final sourceModel = model.sources.firstWhere(
          (element) => element.quality == StreamingQuality.quality1080p);

      return sourceModel;
    } else if (model.sources
        .any((element) => element.quality == StreamingQuality.quality720p)) {
      final sourceModel = model.sources.firstWhere(
          (element) => element.quality == StreamingQuality.quality720p);

      return sourceModel;
    } else if (model.sources
        .any((element) => element.quality == StreamingQuality.quality480p)) {
      final sourceModel = model.sources.firstWhere(
          (element) => element.quality == StreamingQuality.quality480p);

      return sourceModel;
    } else if (model.sources
        .any((element) => element.quality == StreamingQuality.quality360p)) {
      final sourceModel = model.sources.firstWhere(
          (element) => element.quality == StreamingQuality.quality360p);

      return sourceModel;
    } else if (model.sources
        .any((element) => element.quality == StreamingQuality.defaultQuality)) {
      final sourceModel = model.sources.firstWhere(
          (element) => element.quality == StreamingQuality.defaultQuality);

      return sourceModel;
    } else {
      final sourceModel = model.sources.firstWhere(
          (element) => element.quality == StreamingQuality.backupQuality);

      return sourceModel;
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
            iterable_quiver.partition(episodes, 100).toList();

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
