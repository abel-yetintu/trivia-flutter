import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivio/core/enums/difficulty_enum.dart';
import 'package:trivio/core/enums/question_type_enum.dart';
import 'package:trivio/core/utils/trivia_request_params.dart';
import 'package:trivio/features/trivia/domain/entities/trivia_category.dart';

class PreferenceCubit extends Cubit<TriviaRequestParams> {
  PreferenceCubit() : super(const TriviaRequestParams.initial());

  void chooseCategory({required TriviaCategory category}) {
    emit(state.copyWith(category: category));
  }

  void chooseDifficulty({required Difficulty diffculty}) {
    emit(state.copyWith(difficulty: diffculty));
  }

  void chooseQuestionType({required QuestionType questionType}) {
    emit(state.copyWith(type: questionType));
  }

  void chooseAmount({required int amount}) {
    emit(state.copyWith(amount: amount));
  }

  void clear() {
    emit(const TriviaRequestParams.initial());
  }
}
