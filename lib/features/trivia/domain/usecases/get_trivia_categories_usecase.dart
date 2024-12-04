import 'package:dartz/dartz.dart';
import 'package:trivio/features/trivia/domain/entities/trivia_category.dart';
import 'package:trivio/features/trivia/domain/failures/failure.dart';
import 'package:trivio/features/trivia/domain/repositories/trivia_repository.dart';

class GetTriviaCategoriesUsecase {
  const GetTriviaCategoriesUsecase({required this.repository});

  final TriviaRepository repository;

  Future<Either<Failure, List<TriviaCategory>>> execute() async {
    return repository.fetchTriviaCategories();
  }
}
