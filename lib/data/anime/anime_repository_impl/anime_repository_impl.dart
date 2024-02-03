import 'package:anime_red/domain/anime/anime_repository/anime_respository.dart';
import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/common_types/generic_types.dart';
import 'package:anime_red/domain/models/anime_model.dart';
import 'package:anime_red/domain/models/pagination_model.dart';
import 'package:anime_red/domain/models/search_result_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AnimeRepository)
class AnimeRepositoryImpl implements AnimeRepository {
  @override
  FutureEither<AnimeModel> getAnimeInfo({required String id}) {
    // TODO: implement getAnimeInfo
    throw UnimplementedError();
  }

  @override
  FutureEither<AnimeModel> getAvailableServers({required String episodeId}) {
    // TODO: implement getAvailableServers
    throw UnimplementedError();
  }

  @override
  FutureEither<AnimeModel> getRecentReleases(
      {int page = 1, AnimeType type = AnimeType.japanese}) {
    // TODO: implement getRecentReleases
    throw UnimplementedError();
  }

  @override
  FutureEither<AnimeModel> getStreamingLinks(
      {required String episodeId, required AnimeServerName server}) {
    // TODO: implement getStreamingLinks
    throw UnimplementedError();
  }

  @override
  FutureEither<AnimeModel> getTopAiringAnime({required String id}) {
    // TODO: implement getTopAiringAnime
    throw UnimplementedError();
  }

  @override
  FutureEither<PaginationModel<SearchResultModel>> searchAnime(
      {required String query, int page = 1}) async {
    // // try {
    // final response = await AppNetwork.get(
    //     url: AnimeApi.searchForAnimes(query: query),
    //     queryParameters: {
    //       "page": page,
    //     });

    // return response.fold((l) => const Left(ClientFailure()), (r) {
    //   log("${r.data}");
    //   final dto = PaginationDto<SearchResultDto>.fromJson(
    //     jsonEncode(r.data),
    //     SearchResultDto.fromJsonModel,
    //   );

    //   log("Got the result type:   ${dto.datas.runtimeType}");

    //   return const Left(ClientFailure());
    // });
    // // } catch (e) {
    // //   log("Got Error: $e");
    // //   return const Left(ClientFailure());
    // // }
    // TODO: implement getTopAiringAnime
    throw UnimplementedError();
  }
}
