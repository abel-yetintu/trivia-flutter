import 'package:dartz/dartz.dart';
import 'package:trivio/core/utils/trivia_request_params.dart';
import 'package:trivio/features/trivia/domain/entities/question.dart';
import 'package:trivio/features/trivia/domain/entities/trivia_category.dart';
import 'package:trivio/features/trivia/domain/failures/failure.dart';

abstract class TriviaRepository {
  Future<Either<Failure, List<Question>>> fetchTriviaQuestions({required TriviaRequestParams params});
  Future<Either<Failure, List<TriviaCategory>>> fetchTriviaCategories();
}
