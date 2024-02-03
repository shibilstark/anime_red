import 'package:anime_red/domain/common_types/enums.dart';
import 'package:equatable/equatable.dart';

class AnimeStreamingLinkModel extends Equatable {
  final StreamingHeadersModel headers;
  final List<StreamingSourcesModel> sources;

  const AnimeStreamingLinkModel({
    required this.headers,
    required this.sources,
  });

  @override
  List<Object> get props => [
        headers,
        sources,
      ];
}

class StreamingHeadersModel extends Equatable {
  final String referer;
  final String? watchsb;
  final String? userAgent;

  const StreamingHeadersModel({
    required this.referer,
    required this.watchsb,
    required this.userAgent,
  });

  @override
  List<Object?> get props => [
        referer,
        watchsb,
        userAgent,
      ];
}

class StreamingSourcesModel extends Equatable {
  final String url;
  final StreamingQuality quality;
  final bool isM3U8;

  const StreamingSourcesModel({
    required this.url,
    required this.quality,
    required this.isM3U8,
  });

  @override
  List<Object> get props => [
        url,
        quality,
        isM3U8,
      ];
}
