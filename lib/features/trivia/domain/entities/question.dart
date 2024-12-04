import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:trivio/core/enums/difficulty_enum.dart';
import 'package:trivio/core/enums/question_type_enum.dart';

class Question extends Equatable {
  const Question({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  @override
  List<Object?> get props => [type, difficulty, category, question, correctAnswer, incorrectAnswers];

  final QuestionType type;
  final Difficulty difficulty;
  final String category;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  List<String> get options {
    final combinedInput = incorrectAnswers.join() + correctAnswer;

    final seed = combinedInput.hashCode;

    final random = Random(seed.abs());

    final randomizedList = List<String>.from(incorrectAnswers)..add(correctAnswer);

    for (int i = randomizedList.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final temp = randomizedList[i];
      randomizedList[i] = randomizedList[j];
      randomizedList[j] = temp;
    }

    return randomizedList;
  }

  Question copyWith({
    QuestionType? type,
    Difficulty? difficulty,
    String? category,
    String? question,
    String? correctAnswer,
    List<String>? incorrectAnswers,
  }) =>
      Question(
        type: type ?? this.type,
        difficulty: difficulty ?? this.difficulty,
        category: category ?? this.category,
        question: question ?? this.question,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        incorrectAnswers: incorrectAnswers ?? this.incorrectAnswers,
      );
}
