import 'package:equatable/equatable.dart';

class StartEndModel extends Equatable {
  final int start;
  final int end;

  const StartEndModel({
    required this.end,
    required this.start,
  });

  @override
  List<Object?> get props => [start, end];
}
