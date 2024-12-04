import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivio/core/utils/trivia_request_params.dart';
import 'package:trivio/features/trivia/domain/usecases/get_trivia_questions_usecase.dart';
import 'package:trivio/features/trivia/presentation/cubits/question/question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  final GetTriviaQuestionsUsecase _usecase;

  QuestionCubit({required GetTriviaQuestionsUsecase getTriviaQuestionsUsecase})
      : _usecase = getTriviaQuestionsUsecase,
        super(InitialQuestionState());

  Future<void> getTriviaQuestions({required TriviaRequestParams params}) async {
    emit(QuestionsLoading());
    final result = await _usecase.execute(params: params);
    result.fold(
      (failure) {
        emit(QuestionsFailed(message: failure.message));
      },
      (questions) {
        emit(QuestionsFetched(questions: questions));
      },
    );
  }
}
