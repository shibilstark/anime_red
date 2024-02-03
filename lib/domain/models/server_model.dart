import 'package:anime_red/domain/common_types/enums.dart';
import 'package:equatable/equatable.dart';

class ServerModel extends Equatable {
  final AnimeServerName name;
  final String url;

  const ServerModel({
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [
        name,
        url,
      ];
}
