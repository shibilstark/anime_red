import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/common_types/generic_types.dart';
import 'package:anime_red/domain/models/anime_model.dart';
import 'package:anime_red/domain/models/pagination_model.dart';
import 'package:anime_red/domain/models/search_result_model.dart';
import 'package:injectable/injectable.dart';

@injectable
abstract class AnimeRepository {
  FutureEither<AnimeModel> getAnimeInfo({
    required String id,
  });

  /// page [int] default value = 1
  FutureEither<PaginationModel<SearchResultModel>> searchAnime({
    required String query,
    int page = 1,
  });

  /// page [int] default value = 1
  /// type [AnimeType] default value = [AnimeType.japanese]
  FutureEither<AnimeModel> getRecentReleases({
    int page = 1,
    AnimeType type = AnimeType.japanese,
  });

  /// page [int] default value = 1
  FutureEither<AnimeModel> getTopAiringAnime({
    required String id,
  });

  /// pass the id of the epsode/movie you want to play
  FutureEither<AnimeModel> getAvailableServers({
    required String episodeId,
  });

  /// pass the id of the epsode/movie you want to play
  /// can pass [AnimeServerName] defaul value as [AnimeServerName.gogocdn],
  /// but there might be cases like no streaming service available, so making it mandatory
  FutureEither<AnimeModel> getStreamingLinks({
    required String episodeId,
    required AnimeServerName server,
  });
}
