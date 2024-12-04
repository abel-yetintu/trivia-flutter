import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:trivio/core/utils/extensions.dart';
import 'package:trivio/features/trivia/presentation/cubits/game/game_cubit.dart';
import 'package:trivio/features/trivia/presentation/cubits/game/game_state.dart';

class OptionTile extends StatelessWidget {
  final String option;
  const OptionTile({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        final currentState = state as GameOngoingState;
        return GestureDetector(
          onTap: currentState.currentQuestionAnswered
              ? null
              : () {
                  context.read<GameCubit>().answerQuestion(answer: option);
                },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .02, vertical: context.screenHeight * .02),
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  // answer has not been selected
                  !currentState.currentQuestionAnswered
                      ? context.theme.colorScheme.tertiaryContainer
                      :

                      // answer has been selected and the current option is the correct answer
                      currentState.currentQuestion.correctAnswer == option
                          ? Colors.green
                          :

                          // this options has been selected but it's not the right answer
                          (currentState.selectedAnswer == option && currentState.currentQuestion.correctAnswer != option)
                              ? Colors.red
                              :

                              // this option is not selected and it's not the correct answer
                              context.theme.colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              HtmlUnescape().convert(option),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
