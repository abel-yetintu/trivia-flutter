import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:trivio/core/utils/trivia_request_params.dart';
import 'package:trivio/features/trivia/data/data_sources/remote/trivia_remote_data_source.dart';
import 'package:trivio/features/trivia/domain/entities/question.dart';
import 'package:trivio/features/trivia/domain/entities/trivia_category.dart';
import 'package:trivio/features/trivia/domain/failures/failure.dart';
import 'package:trivio/features/trivia/domain/repositories/trivia_repository.dart';

class TriviaRepositoryImpl implements TriviaRepository {
  const TriviaRepositoryImpl({required this.triviaRemoteDataSource});

  final TriviaRemoteDataSource triviaRemoteDataSource;

  @override
  Future<Either<Failure, List<Question>>> fetchTriviaQuestions({required TriviaRequestParams params}) async {
    try {
      final questionModels = await triviaRemoteDataSource.fetchTriviaQuestions(params: params);
      final questionEntities = questionModels.map((questionModel) => questionModel.mapToEntity()).toList();
      return Right(questionEntities);
    } on DioException catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TriviaCategory>>> fetchTriviaCategories() async {
    try {
      final triviaCategoryModels = await triviaRemoteDataSource.fetchTriviaCategories();
      final triviaCategoryEntities = triviaCategoryModels.map((triviaCategoryModel) => triviaCategoryModel.mapToEntity()).toList();
      return Right(triviaCategoryEntities);
    } on DioException catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
