import 'package:anime_red/data/anime/anime_api/anime_api_service.dart';
import 'package:anime_red/domain/anime/anime_repository/anime_respository.dart';
import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/common_types/generic_types.dart';
import 'package:anime_red/domain/models/anime_model.dart';
import 'package:anime_red/domain/models/anime_streaminglink_model.dart';
import 'package:anime_red/domain/models/pagination_model.dart';
import 'package:anime_red/domain/models/recent_episode_model.dart';
import 'package:anime_red/domain/models/search_result_model.dart';
import 'package:anime_red/domain/models/server_model.dart';
import 'package:anime_red/domain/models/top_airing_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AnimeRepository)
class AnimeRepositoryImpl implements AnimeRepository {
  final AnimeApiService api = AnimeApiService();

  @override
  FutureEither<PaginationModel<SearchResultModel>> searchAnime(
          {required String query, int page = 1}) async =>
      api.searchAnime(query: query, page: page);

  @override
  FutureEither<AnimeModel> getAnimeInfo({required String id}) async =>
      api.getAnimeInfo(id: id);

  @override
  FutureEither<List<ServerModel>> getAvailableServers({
    required String episodeId,
  }) async =>
      api.getAvailableServers(episodeId: episodeId);

  @override
  FutureEither<PaginationModel<RecentEpisodeModel>> getRecentReleases(
          {int page = 1, AnimeType type = AnimeType.japanese}) async =>
      api.getRecentReleases(page: page, type: type);

  @override
  FutureEither<AnimeStreamingLinkModel> getStreamingLinks(
          {required String episodeId, required AnimeServerName server}) async =>
      api.getStreamingLinks(episodeId: episodeId, server: server);

  @override
  FutureEither<PaginationModel<TopAiringModel>> getTopAiringAnime(
          {int page = 1}) async =>
      api.getTopAiringAnime(page: page);
}
