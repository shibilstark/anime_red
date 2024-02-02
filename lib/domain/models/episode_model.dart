import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  final String id;
  final String url;
  final int episodeNumber;

  const EpisodeModel({
    required this.id,
    required this.url,
    required this.episodeNumber,
  });

  @override
  List<Object> get props => [
        id,
        url,
        episodeNumber,
      ];
}
