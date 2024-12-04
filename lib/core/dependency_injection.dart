import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:trivio/core/utils/trivia_http_client.dart';
import 'package:trivio/features/trivia/data/data_sources/remote/trivia_remote_data_source.dart';
import 'package:trivio/features/trivia/data/repositories/trivia_repository_impl.dart';
import 'package:trivio/features/trivia/domain/entities/question.dart';
import 'package:trivio/features/trivia/domain/repositories/trivia_repository.dart';
import 'package:trivio/features/trivia/domain/usecases/get_trivia_categories_usecase.dart';
import 'package:trivio/features/trivia/domain/usecases/get_trivia_questions_usecase.dart';
import 'package:trivio/features/trivia/presentation/cubits/category/category_cubit.dart';
import 'package:trivio/features/trivia/presentation/cubits/game/game_cubit.dart';
import 'package:trivio/features/trivia/presentation/cubits/question/question_cubit.dart';

final sl = GetIt.instance;

Future<void> initSL() async {
  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());

  // Cubits

  sl.registerFactory(() => CategoryCubit(getTriviaCategoriesUsecase: sl()));

  sl.registerFactory(() => QuestionCubit(getTriviaQuestionsUsecase: sl()));

  sl.registerFactoryParam<GameCubit, List<Question>, void>((questions, _) => GameCubit(questions: questions));

  // Usecases

  sl.registerLazySingleton(() => GetTriviaCategoriesUsecase(repository: sl()));

  sl.registerLazySingleton(() => GetTriviaQuestionsUsecase(repository: sl()));

  // Repositories

  sl.registerLazySingleton<TriviaRepository>(() => TriviaRepositoryImpl(triviaRemoteDataSource: sl()));

  // Remote data sources

  sl.registerLazySingleton<TriviaRemoteDataSource>(() => TriviaRemoteDataSourceImpl(client: sl()));

  // Http client

  sl.registerLazySingleton<Dio>(() => TriviaHttpClient.client);
}
