import 'package:equatable/equatable.dart';
import 'package:trivio/core/enums/difficulty_enum.dart';
import 'package:trivio/core/enums/question_type_enum.dart';
import 'package:trivio/features/trivia/domain/entities/trivia_category.dart';

class TriviaRequestParams extends Equatable {
  const TriviaRequestParams({
    required this.amount,
    required this.category,
    required this.difficulty,
    required this.type,
  });

  const TriviaRequestParams.initial()
      : amount = 10,
        category = null,
        difficulty = Difficulty.any,
        type = QuestionType.any;

  final int amount;
  final TriviaCategory? category;
  final Difficulty difficulty;
  final QuestionType type;

  @override
  List<Object?> get props => [amount, category, difficulty, type];

  TriviaRequestParams copyWith({
    int? amount,
    TriviaCategory? category,
    Difficulty? difficulty,
    QuestionType? type,
  }) {
    return TriviaRequestParams(
      amount: amount ?? this.amount,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      type: type ?? this.type,
    );
  }
}
