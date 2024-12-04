import 'package:equatable/equatable.dart';
import 'package:trivio/features/trivia/domain/entities/question.dart';

sealed class GameState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GameOngoingState extends GameState {
  final List<Question> questions;
  final String? selectedAnswer;
  final bool currentQuestionAnswered;
  final int score;
  final int answeredQuestions;
  final int currentIndex;
  Question get currentQuestion => questions[currentIndex];

  GameOngoingState({
    required this.questions,
    this.selectedAnswer,
    this.currentQuestionAnswered = false,
    this.score = 0,
    this.answeredQuestions = 0,
    this.currentIndex = 0,
  });

  @override
  List<Object?> get props => [questions, currentIndex, answeredQuestions, score, currentQuestionAnswered, selectedAnswer];

  GameOngoingState copyWith({
    List<Question>? questions,
    int? currentIndex,
    int? answeredQuestions,
    int? score,
    bool? currentQuestionAnswered,
    String? selectedAnswer,
  }) {
    return GameOngoingState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      answeredQuestions: answeredQuestions ?? this.answeredQuestions,
      score: score ?? this.score,
      currentQuestionAnswered: currentQuestionAnswered ?? this.currentQuestionAnswered,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }
}

final class GameFinishedState extends GameState {
  final int score;
  final int numberOfQuestions;

  GameFinishedState({required this.score, required this.numberOfQuestions});

  @override
  List<Object?> get props => [score, numberOfQuestions];
}
