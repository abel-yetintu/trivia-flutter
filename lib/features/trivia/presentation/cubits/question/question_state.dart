import 'package:equatable/equatable.dart';
import 'package:trivio/features/trivia/domain/entities/question.dart';

sealed class QuestionState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class InitialQuestionState extends QuestionState {}

final class QuestionsLoading extends QuestionState {}

final class QuestionsFetched extends QuestionState {
  final List<Question> questions;

  QuestionsFetched({required this.questions});

  @override
  List<Object?> get props => [questions];
}

final class QuestionsFailed extends QuestionState {
  final String message;

  QuestionsFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
