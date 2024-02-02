import 'package:equatable/equatable.dart';

class ServerModel extends Equatable {
  final String name;
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
