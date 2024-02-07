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
import 'package:anime_red/domain/watch_history/watch_history_model.dart/watch_history_model.dart';
import 'package:anime_red/domain/watch_history/watch_history_repository.dart/watch_history_repository.dart';
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
  final WatchHistoryRepository watchHistoryRepository;

  AnimeBloc(
    this.repository,
    this.watchHistoryRepository,
  ) : super(AnimeInitial()) {
    on<AnimeGetInfo>(_getAnimeInfoAndEpisodes);
    on<AnimeGetEpisodeLink>(_getEpisodeLinks);
    on<AnimeChangeStreamingServer>(_changeStreamingServer);
    on<AnimeChangeStreamingQuality>(_changeStreamingQuality);
    on<AnimePlayLastPlayedEpisode>(_playLastPlayedEpisode);
    // on<AnimeUpdateLastPlayedPosition>(_updateLastPlayedPosition);
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
              currentPlayingEpisodeId: null,
            ),
          );
        });
      });
    } else {
      const failure = InternetFailure();
      emit(AnimeFailure(type: failure.type, message: failure.message));
    }
  }

  // _updateLastPlayedPosition(
  //     AnimeUpdateLastPlayedPosition event, Emitter<AnimeState> emit) async {
  //   await watchHistoryRepository
  //       .updateStatus(
  //           id: event.id,
  //           newEpisodeId: event.episodeId,
  //           newPosition: event.lastPostion,)
  //       .then((value) {
  //     final currentState = state;
  //     if (currentState is AnimeSuccess) {
  //       emit(AnimeSuccess(
  //         anime: currentState.anime,
  //         startEndList: currentState.startEndList,
  //         currentPlayingEpisodeId: currentState.currentPlayingEpisodeId,
  //         playerData: currentState.playerData?.fold((l) {
  //           return Left(l);
  //         },
  //             (newPm) => Right(AnimePlayerDataModel(
  //                   currentLink: newPm.currentLink,
  //                   currentServer: newPm.currentServer,
  //                   servers: newPm.servers,
  //                   streamingLinks: newPm.streamingLinks,
  //                   currentPlayPostion: event.lastPostion,
  //                 ))),
  //       ));
  //     }
  //   });
  // }

  _playLastPlayedEpisode(
    AnimePlayLastPlayedEpisode event,
    Emitter<AnimeState> emit,
  ) async {
    final currentState = state;

    if (currentState is AnimeSuccess) {
      emit(
        AnimeSuccess(
          anime: currentState.anime,
          startEndList:
              List.from(_generateStartEndList(currentState.anime.episodes)),
          playerData: null,
          currentPlayingEpisodeId: null,
        ),
      );

      await watchHistoryRepository
          .getHistoryById(event.animeId)
          .then((model) async {
        if (model == null) {
          await _getEpisodeLinks(
              AnimeGetEpisodeLink(
                currentState.anime.episodes.first.id,
              ),
              emit);
        } else {
          await _getEpisodeLinks(
              AnimeGetEpisodeLink(
                model.episodeId,
              ),
              emit);
        }
      });
    }
  }

  _changeStreamingServer(
    AnimeChangeStreamingServer event,
    Emitter<AnimeState> emit,
  ) async {
    final currentState = state;

    if (currentState is AnimeSuccess) {
      if (currentState.playerData != null) {
        emit(
          AnimeSuccess(
            anime: currentState.anime,
            startEndList:
                List.from(_generateStartEndList(currentState.anime.episodes)),
            playerData: null,
            currentPlayingEpisodeId: event.episodeId,
          ),
        );

        await currentState.playerData!.fold((failure) async => null,
            (playerData) async {
          await repository
              .getStreamingLinks(
                  episodeId: event.episodeId, server: event.server.name)
              .then(
            (result) async {
              await result.fold((failure) {
                emit(
                  AnimeSuccess(
                    anime: currentState.anime,
                    startEndList: List.from(
                        _generateStartEndList(currentState.anime.episodes)),
                    playerData: Left(failure),
                    currentPlayingEpisodeId: event.episodeId,
                  ),
                );
              }, (streamingLinks) async {
                emit(
                  AnimeSuccess(
                    anime: currentState.anime,
                    startEndList: List.from(
                        _generateStartEndList(currentState.anime.episodes)),
                    playerData: Right(
                      AnimePlayerDataModel(
                        currentLink:
                            _getStreamingLinkByHierarchy(streamingLinks),
                        currentServer: event.server,
                        servers: playerData.servers,
                        streamingLinks: streamingLinks,
                        currentPlayPostion:
                            await watchHistoryRepository.getDurationFromEpisode(
                          id: event.episodeId,
                          episodeId: currentState.anime.id,
                        ),
                      ),
                    ),
                    currentPlayingEpisodeId: event.episodeId,
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
      emit(
        AnimeSuccess(
          anime: currentState.anime,
          startEndList:
              List.from(_generateStartEndList(currentState.anime.episodes)),
          playerData: null,
          currentPlayingEpisodeId: event.currentEpisodeId,
        ),
      );
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
                  currentPlayPostion: playerData.currentPlayPostion,
                ),
              ),
              currentPlayingEpisodeId: event.currentEpisodeId,
            ));
          },
        );
      }
    }
  }

  _getEpisodeLinks(AnimeGetEpisodeLink event, Emitter<AnimeState> emit) async {
    final currentState = state;

    if (currentState is AnimeSuccess) {
      emit(
        AnimeSuccess(
          anime: currentState.anime,
          startEndList:
              List.from(_generateStartEndList(currentState.anime.episodes)),
          playerData: null,
          currentPlayingEpisodeId: event.episodeId,
        ),
      );
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
                  currentPlayingEpisodeId: event.episodeId),
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
                .then((result) async {
              await result.fold((failure) async {
                emit(
                  AnimeSuccess(
                      anime: currentState.anime,
                      startEndList: List.from(
                          _generateStartEndList(currentState.anime.episodes)),
                      playerData: Left(failure),
                      currentPlayingEpisodeId: event.episodeId),
                );
              }, (streamingLinks) async {
                await watchHistoryRepository
                    .getDurationFromEpisode(
                  id: currentState.anime.id,
                  episodeId: event.episodeId,
                )
                    .then((lastPlayedPositionFromDB) async {
                  await watchHistoryRepository
                      .addNewHistory(WatchHistoryModel(
                    id: currentState.anime.id,
                    image: currentState.anime.image,
                    title: currentState.anime.title,
                    episodeId: event.episodeId,
                    currentPosition: lastPlayedPositionFromDB,
                    currentEpisodeCount: currentState.anime.episodes
                        .firstWhere((element) => element.id == event.episodeId)
                        .episodeNumber,
                    subOrDub: currentState.anime.subOrDub,
                    genres: currentState.anime.genres,
                    lastUpdatedAt: DateTime.now(),
                    totalLength: null,
                  ))
                      .then((_) async {
                    emit(
                      AnimeSuccess(
                          anime: currentState.anime,
                          startEndList: List.from(_generateStartEndList(
                              currentState.anime.episodes)),
                          playerData: Right(
                            AnimePlayerDataModel(
                              currentLink:
                                  _getStreamingLinkByHierarchy(streamingLinks),
                              currentServer: selectedServer,
                              servers: availableServers,
                              streamingLinks: streamingLinks,
                              currentPlayPostion: lastPlayedPositionFromDB,
                            ),
                          ),
                          currentPlayingEpisodeId: event.episodeId),
                    );
                  });
                });
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
              currentPlayingEpisodeId: event.episodeId),
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
