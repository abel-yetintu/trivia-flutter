import 'package:dio/dio.dart';

class TriviaHttpClient {
  static final Dio client = Dio(
    BaseOptions(
      baseUrl: 'https://opentdb.com',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );
}
