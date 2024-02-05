import 'package:anime_red/domain/models/anime_streaminglink_model.dart';
import 'package:anime_red/domain/models/server_model.dart';
import 'package:equatable/equatable.dart';

class AnimePlayerDataModel extends Equatable {
  final List<ServerModel> servers;
  final ServerModel currentServer;
  final StreamingSourcesModel currentLink;
  final AnimeStreamingLinkModel streamingLinks;

  const AnimePlayerDataModel({
    required this.currentLink,
    required this.currentServer,
    required this.servers,
    required this.streamingLinks,
  });

  @override
  List<Object?> get props => [
        currentLink,
        currentServer,
        servers,
        streamingLinks,
      ];
}
