import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivio/core/dependency_injection.dart';
import 'package:trivio/core/utils/extensions.dart';
import 'package:trivio/core/utils/helper_widgets.dart';
import 'package:trivio/features/trivia/domain/entities/question.dart';
import 'package:trivio/features/trivia/presentation/cubits/game/game_cubit.dart';
import 'package:trivio/features/trivia/presentation/cubits/game/game_state.dart';
import 'package:trivio/features/trivia/presentation/widgets/question_card.dart';

class GameScreen extends StatelessWidget {
  final List<Question> questions;
  const GameScreen({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GameCubit>(param1: questions),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(context.screenWidth * .05, context.screenHeight * .04, context.screenWidth * .05, 0),
            child: BlocBuilder<GameCubit, GameState>(
              builder: (context, state) {
                switch (state) {
                  case GameOngoingState():
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Text('Question ${state.currentIndex + 1} out of ${state.questions.length}'),
                          addVerticalSpace(context.screenHeight * .04),
                          Text('Score:  ${state.score}/${state.answeredQuestions}'),
                          addVerticalSpace(context.screenHeight * .04),
                          QuestionCard(
                            question: state.currentQuestion,
                          ),
                          addVerticalSpace(context.screenHeight * .04),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: state.currentQuestionAnswered
                                  ? () {
                                      context.read<GameCubit>().nextQuestion();
                                    }
                                  : null,
                              child: const Text('Next'),
                            ),
                          )
                        ],
                      ),
                    );
                  case GameFinishedState():
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('You got ${state.score} questions right out of ${state.numberOfQuestions}'),
                          addVerticalSpace(context.screenHeight * .04),
                          FilledButton(
                            onPressed: () {
                              sl<GlobalKey<NavigatorState>>().currentState?.pop();
                            },
                            child: const Text('Finish'),
                          )
                        ],
                      ),
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
