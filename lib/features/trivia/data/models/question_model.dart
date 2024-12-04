import 'package:trivio/core/enums/difficulty_enum.dart';
import 'package:trivio/core/enums/question_type_enum.dart';
import 'package:trivio/core/utils/data_mapper.dart';
import 'package:trivio/features/trivia/domain/entities/question.dart';

class QuestionModel extends DataMapper<Question> {
  QuestionModel({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  final String type;
  final String difficulty;
  final String category;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  @override
  Question mapToEntity() {
    return Question(
      type: QuestionType.fromString(type),
      difficulty: Difficulty.fromString(difficulty),
      category: category,
      question: question,
      correctAnswer: correctAnswer,
      incorrectAnswers: incorrectAnswers,
    );
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      type: map['type'],
      difficulty: map['difficulty'],
      category: map['category'],
      question: map['question'],
      correctAnswer: map['correct_answer'],
      incorrectAnswers: List<String>.from(
        map['incorrect_answers'].map((ia) => ia),
      ),
    );
  }
}
