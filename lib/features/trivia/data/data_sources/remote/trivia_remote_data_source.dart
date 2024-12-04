import 'package:dio/dio.dart';
import 'package:trivio/core/enums/difficulty_enum.dart';
import 'package:trivio/core/enums/question_type_enum.dart';
import 'package:trivio/core/utils/trivia_request_params.dart';
import 'package:trivio/features/trivia/data/models/question_model.dart';
import 'package:trivio/features/trivia/data/models/trivia_category_model.dart';

abstract class TriviaRemoteDataSource {
  Future<List<QuestionModel>> fetchTriviaQuestions({required TriviaRequestParams params});
  Future<List<TriviaCategoryModel>> fetchTriviaCategories();
}

class TriviaRemoteDataSourceImpl implements TriviaRemoteDataSource {
  TriviaRemoteDataSourceImpl({required this.client});

  final Dio client;

  @override
  Future<List<QuestionModel>> fetchTriviaQuestions({required TriviaRequestParams params}) async {
    final Map<String, dynamic> queryPrameters = {
      'amount': params.amount,
    };

    if (params.category?.id != -1 && params.category != null) {
      queryPrameters['category'] = params.category!.id;
    }

    if (params.difficulty != Difficulty.any) {
      queryPrameters['difficulty'] = params.difficulty.name;
    }

    switch (params.type) {
      case QuestionType.multipleChoice:
        queryPrameters['type'] = 'multiple';
      case QuestionType.trueFalse:
        queryPrameters['type'] = 'boolean';
      case QuestionType.any:
        break;
    }

    final response = await client.get('/api.php', queryParameters: queryPrameters);
    final result = response.data;
    return List<QuestionModel>.from(result['results'].map(
      (map) => QuestionModel.fromMap(map),
    ));
  }

  @override
  Future<List<TriviaCategoryModel>> fetchTriviaCategories() async {
    final response = await client.get('/api_category.php');
    final result = response.data;
    return List<TriviaCategoryModel>.from(result['trivia_categories'].map(
      (map) => TriviaCategoryModel.fromMap(map),
    ));
  }
}
