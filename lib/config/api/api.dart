import 'package:anime_red/config/config.dart';

class AnimeApi {
  /// Dont use slash at end
  static final String _baseUrl = BuildConfig.instance.baseUrl;

  /// Parameter Type Query
  /// page:	[int]	The page number of results to return.
  /// Optional
  /// Default 1
  ///
  /// Parameter Type Query
  /// type:	[int]	The type of anime to get, i.e. sub or dub. 1: Japanese Dub, English Sub; 2: English Dub, No Sub; 3: Chinese Dub, English Sub.
  /// Optional
  /// Default 1
  static String getRecentEpisodes() =>
      "$_baseUrl/anime/gogoanime/recent-episodes";

  /// Parameter Type Query
  /// page:	[int]	The page number of results to return.
  /// Optional
  /// Default 1
  static String getTopAiringAnimes() => "$_baseUrl/anime/gogoanime/top-airing";

  /// Parameter Type Path
  /// id:	[String]	The ID of the anime; i.e. provided by searching for said anime and selecting the correct one.
  /// Required
  static String getAnimeInfo(String id) => "$_baseUrl/anime/gogoanime/info/$id";

  /// Parameter Type Path
  /// query:	[String]	The search query; i.e. the title of the item you are looking for.
  /// Required
  ///
  /// Parameter Type Query
  /// query:	[Enum]"gogocdn", "streamsb", "vidstreaming"
  /// Optional
  /// Default "gogocdn"
  static String getAnimeEpisodeStreamingLinks({required String episodeId}) =>
      "$_baseUrl/anime/gogoanime/watch/$episodeId";

  /// Parameter Type Path
  /// query:	[String]the title/episodeId of the item you are looking for.
  /// Required
  static String getAvailableServers({required String episodeId}) =>
      "$_baseUrl/anime/gogoanime/servers/$episodeId";

  /// Parameter Type Path
  /// query:	[String]	The search query; i.e. the title of the item you are looking for.
  /// Required
  ///
  /// Parameter Type Query
  /// number:	[String]page number
  /// Optional
  /// Default 1
  static String searchForAnimes({required String query}) =>
      "$_baseUrl/anime/gogoanime/$query";
}
