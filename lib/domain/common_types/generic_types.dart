import 'package:anime_red/domain/common_types/failures.dart';
import 'package:dartz/dartz.dart';

typedef FutureEither<T> = Future<Either<AppFailure, T>>;
typedef EitherFailure<T> = Either<AppFailure, T>;
