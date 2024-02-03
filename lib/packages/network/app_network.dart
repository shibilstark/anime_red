import 'dart:developer';

import 'package:anime_red/config/build_config/build_config.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AppNetwork {
  static final _client = Dio(BaseOptions(
    receiveDataWhenStatusError: true,
    sendTimeout: BuildConfig.instance.requestTimeOut * 1000,
    connectTimeout: BuildConfig.instance.requestTimeOut * 1000,
    receiveTimeout: BuildConfig.instance.requestTimeOut * 1000,
  ));
  static Future<Either<String, Response<dynamic>>> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await _client.get(url, queryParameters: queryParameters);

      return Right(res);
    } on DioException catch (e) {
      log("${e.message} link: ${e.response?.realUri} err: ${e.error} code:${e.response?.statusCode} ");

      return Left(e.message ?? "Something went wrong on server");
    } catch (e) {
      log("$e");
      return const Left(
          "Oops, it seems like something went wrong please try again later");
    }
  }
}
