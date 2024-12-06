import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivio/core/dependency_injection.dart';
import 'package:trivio/core/utils/extensions.dart';
import 'package:trivio/core/utils/helper_widgets.dart';
import 'package:trivio/features/trivia/domain/entities/question.dart';
import 'package:trivio/features/trivia/domain/entities/ticker.dart';
import 'package:trivio/features/trivia/presentation/cubits/game/game_cubit.dart';
import 'package:trivio/features/trivia/presentation/cubits/game/game_state.dart';
import 'package:trivio/features/trivia/presentation/cubits/timer/timer_cubit.dart';
import 'package:trivio/features/trivia/presentation/cubits/timer/timer_state.dart';
import 'package:trivio/features/trivia/presentation/widgets/question_card.dart';

class GameScreen extends StatelessWidget {
  final List<Question> questions;
  const GameScreen({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    final timeForGame = ((questions.length / 4) * 60).round();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TimerCubit(seconds: timeForGame, ticker: const Ticker()),
        ),
        BlocProvider(
          create: (_) => sl<GameCubit>(param1: questions),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(context.screenWidth * .05, 0, context.screenWidth * .05, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Timer

                addVerticalSpace(context.screenHeight * .02),
                BlocConsumer<TimerCubit, TimerState>(
                  listener: (context, state) {
                    if (state is TimerRunComplete && context.read<GameCubit>().state is GameOngoingState) {
                      context.read<GameCubit>().finishGame();
                    }
                  },
                  builder: (context, state) {
                    final minutesStr = ((state.remainingSeconds / 60) % 60).floor().toString().padLeft(2, '0');
                    final secondsStr = (state.remainingSeconds % 60).floor().toString().padLeft(2, '0');
                    if (context.read<GameCubit>().state is GameFinishedState) {
                      return const SizedBox.shrink();
                    }
                    return Text("$minutesStr:$secondsStr");
                  },
                ),
                addVerticalSpace(context.screenHeight * .04),

                // Game

                BlocBuilder<GameCubit, GameState>(
                  builder: (context, state) {
                    switch (state) {
                      case GameOngoingState():
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              // Current question number

                              Text('Question ${state.currentIndex + 1} out of ${state.questions.length}'),
                              addVerticalSpace(context.screenHeight * .04),

                              // Score

                              Text('Score:  ${state.score}/${state.answeredQuestions}'),
                              addVerticalSpace(context.screenHeight * .04),

                              // Question

                              QuestionCard(
                                question: state.currentQuestion,
                              ),
                              addVerticalSpace(context.screenHeight * .04),

                              // Next question button

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
