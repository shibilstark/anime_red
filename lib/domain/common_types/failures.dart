// ignore_for_file: overridden_fields

import 'package:anime_red/domain/common_types/enums.dart';

sealed class AppFailure {
  final FailureType type;
  final String message;

  const AppFailure({
    required this.message,
    required this.type,
  });
}

class ClientFailure extends AppFailure {
  @override
  const ClientFailure()
      : super(
          message: "Something went wrong, please try again later",
          type: FailureType.client,
        );
}

class ServerFailure extends AppFailure {
  @override
  final String message;

  const ServerFailure({
    required this.message,
  }) : super(
          message: message,
          type: FailureType.server,
        );
}

class UnknownFailure extends AppFailure {
  const UnknownFailure()
      : super(
          message:
              "Oops, it seems like something went wrong please try again later",
          type: FailureType.unknown,
        );
}

class InternetFailure extends AppFailure {
  const InternetFailure()
      : super(
          message:
              "Oops, No network found, check your connection and try again later",
          type: FailureType.unknown,
        );
}
