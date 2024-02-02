import 'package:equatable/equatable.dart';

class PaginationModel<T> extends Equatable {
  final int currentPage;
  final bool hasNextPage;
  final List<T> datas;

  const PaginationModel({
    required this.currentPage,
    required this.hasNextPage,
    required this.datas,
  });

  @override
  List<Object?> get props => [
        currentPage,
        hasNextPage,
        datas,
      ];
}
