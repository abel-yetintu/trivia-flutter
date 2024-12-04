import 'package:dartz/dartz.dart';
import 'package:trivio/core/utils/trivia_request_params.dart';
import 'package:trivio/features/trivia/domain/entities/question.dart';
import 'package:trivio/features/trivia/domain/failures/failure.dart';
import 'package:trivio/features/trivia/domain/repositories/trivia_repository.dart';

class GetTriviaQuestionsUsecase {
  const GetTriviaQuestionsUsecase({required this.repository});

  final TriviaRepository repository;

  Future<Either<Failure, List<Question>>> execute({required TriviaRequestParams params}) async {
    return repository.fetchTriviaQuestions(params: params);
  }
}
