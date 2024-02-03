import 'dart:convert';
import 'dart:developer';

import 'package:anime_red/config/config.dart';
import 'package:anime_red/data/anime/dtos/anime_dto.dart';
import 'package:anime_red/data/anime/dtos/anime_streaminglink_dto.dart';
import 'package:anime_red/data/anime/dtos/pagination_dto.dart';
import 'package:anime_red/data/anime/dtos/recent_episode_dto.dart';
import 'package:anime_red/data/anime/dtos/search_result_dto.dart';
import 'package:anime_red/data/anime/dtos/server_dto.dart';
import 'package:anime_red/data/anime/dtos/top_airing_dto.dart';
import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/common_types/failures.dart';
import 'package:anime_red/domain/common_types/generic_types.dart';
import 'package:anime_red/domain/models/anime_model.dart';
import 'package:anime_red/domain/models/anime_streaminglink_model.dart';
import 'package:anime_red/domain/models/pagination_model.dart';
import 'package:anime_red/domain/models/recent_episode_model.dart';
import 'package:anime_red/domain/models/search_result_model.dart';
import 'package:anime_red/domain/models/server_model.dart';
import 'package:anime_red/domain/models/top_airing_model.dart';
import 'package:anime_red/packages/network/app_network.dart';
import 'package:dartz/dartz.dart';

class AnimeApiService {
  FutureEither<PaginationModel<SearchResultModel>> searchAnime(
      {required String query, int page = 1}) async {
    try {
      final response = await AppNetwork.get(
          url: AnimeApi.searchForAnimes(query: query),
          queryParameters: {
            "page": page,
          });

      return response.fold((l) => const Left(ClientFailure()), (r) {
        final dto = PaginationDto<SearchResultDto>.fromJson(
          jsonEncode(r.data),
          SearchResultDto.fromJsonModel,
        );

        final model = PaginationModel<SearchResultModel>(
          currentPage: dto.currentPage,
          hasNextPage: dto.hasNextPage,
          datas: dto.datas.map((e) => e.toModel()).toList(),
        );
        return Right(model);
      });
    } catch (e) {
      log("Got Error while parsing: $e");
      return const Left(ClientFailure());
    }
  }

  FutureEither<AnimeModel> getAnimeInfo({required String id}) async {
    try {
      final response = await AppNetwork.get(url: AnimeApi.getAnimeInfo(id));

      return response.fold((l) => const Left(ClientFailure()), (r) {
        final dto = AnimeDto.fromJson(r.data);

        return Right(dto.toModel());
      });
    } catch (e) {
      log("Got Error while parsing: $e");
      return const Left(ClientFailure());
    }
  }

  FutureEither<List<ServerModel>> getAvailableServers({
    required String episodeId,
  }) async {
    try {
      final response = await AppNetwork.get(
          url: AnimeApi.getAvailableServers(episodeId: episodeId));

      return response.fold((l) => const Left(ClientFailure()), (r) {
        final rawData = r.data as List<dynamic>;

        return Right(
          List.from(
            rawData.map((e) => ServerDto.fromJson(e).toModel()).toList(),
          ),
        );
      });
    } catch (e) {
      log("Got Error while parsing: $e");
      return const Left(ClientFailure());
    }
  }

  FutureEither<PaginationModel<RecentEpisodeModel>> getRecentReleases(
      {int page = 1, AnimeType type = AnimeType.japanese}) async {
    try {
      final response = await AppNetwork.get(
          url: AnimeApi.getRecentEpisodes(),
          queryParameters: {"page": page, "type": type.queryValue});

      return response.fold((l) => const Left(ClientFailure()), (r) {
        final dto = PaginationDto<RecentEpisodeDto>.fromJson(
          jsonEncode(r.data),
          SearchResultDto.fromJsonModel,
        );

        final model = PaginationModel<RecentEpisodeModel>(
          currentPage: dto.currentPage,
          hasNextPage: dto.hasNextPage,
          datas: dto.datas.map((e) => e.toModel()).toList(),
        );
        return Right(model);
      });
    } catch (e) {
      log("Got Error while parsing: $e");
      return const Left(ClientFailure());
    }
  }

  FutureEither<AnimeStreamingLinkModel> getStreamingLinks(
      {required String episodeId, required AnimeServerName server}) async {
    try {
      final response = await AppNetwork.get(
          url: AnimeApi.getAnimeEpisodeStreamingLinks(episodeId: episodeId),
          queryParameters: {
            "server": server.queryValue,
          });

      return response.fold((l) => const Left(ClientFailure()), (r) {
        final dto = AnimeStreamingLinkDto.fromJson(r.data);

        return Right(dto.toModel());
      });
    } catch (e) {
      log("Got Error while parsing: $e");
      return const Left(ClientFailure());
    }
  }

  FutureEither<PaginationModel<TopAiringModel>> getTopAiringAnime(
      {required page}) async {
    try {
      final response = await AppNetwork.get(
          url: AnimeApi.getTopAiringAnimes(), queryParameters: {"page": page});

      return response.fold((l) => const Left(ClientFailure()), (r) {
        final dto = PaginationDto<TopAiringDto>.fromJson(
          jsonEncode(r.data),
          SearchResultDto.fromJsonModel,
        );

        final model = PaginationModel<TopAiringModel>(
          currentPage: dto.currentPage,
          hasNextPage: dto.hasNextPage,
          datas: dto.datas.map((e) => e.toModel()).toList(),
        );
        return Right(model);
      });
    } catch (e) {
      log("Got Error while parsing: $e");
      return const Left(ClientFailure());
    }
  }
}
