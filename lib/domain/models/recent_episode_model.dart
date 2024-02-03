import 'package:equatable/equatable.dart';

class RecentEpisodeModel extends Equatable {
  final String id;
  final String title;
  final String image;
  final String eposodeId;
  final String url;
  final int episodeNumber;

  const RecentEpisodeModel({
    required this.id,
    required this.title,
    required this.image,
    required this.url,
    required this.episodeNumber,
    required this.eposodeId,
  });

  @override
  List<Object> get props => [
        id,
        title,
        image,
        url,
        episodeNumber,
        eposodeId,
      ];
}
