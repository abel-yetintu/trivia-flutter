import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivio/features/trivia/domain/entities/question.dart';
import 'package:trivio/features/trivia/presentation/cubits/game/game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({required List<Question> questions}) : super(GameOngoingState(questions: questions));

  void answerQuestion({required String answer}) {
    final currentState = state as GameOngoingState;

    // update the selected answer for the current question
    final selectedAnswer = answer;

    // update current question answered flag
    const questionsAnswered = true;

    // update score
    final newScore = currentState.currentQuestion.correctAnswer == answer ? currentState.score + 1 : currentState.score;

    // update amount of questions answered
    final answeredQuestions = currentState.answeredQuestions + 1;

    emit(currentState.copyWith(
        score: newScore, selectedAnswer: selectedAnswer, currentQuestionAnswered: questionsAnswered, answeredQuestions: answeredQuestions));
  }

  void nextQuestion() {
    final currentState = state as GameOngoingState;

    // update the current index for the question
    final newIndex = currentState.currentIndex + 1;

    if (currentState.currentIndex == currentState.questions.length - 1) {
      finishGame();
      return;
    }

    emit(currentState.copyWith(
      currentIndex: newIndex,
      selectedAnswer: null,
      currentQuestionAnswered: false,
    ));
  }

  void finishGame() {
    final currentState = state as GameOngoingState;
    emit(GameFinishedState(score: currentState.score, numberOfQuestions: currentState.questions.length));
  }
}
