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
import 'package:trivio/features/trivia/presentation/widgets/question_card.dart';
import 'package:trivio/features/trivia/presentation/widgets/result_card.dart';
import 'package:trivio/features/trivia/presentation/widgets/timer_widget.dart';

class GameScreen extends StatelessWidget {
  final List<Question> questions;
  const GameScreen({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    final timeForGame = ((questions.length / 4) * 60).round();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TimerCubit(totalSeconds: timeForGame, seconds: timeForGame, ticker: const Ticker()),
        ),
        BlocProvider(
          create: (_) => sl<GameCubit>(param1: questions),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(context.screenWidth * .05, 0, context.screenWidth * .05, 0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Timer
              
                  addVerticalSpace(context.screenHeight * .03),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TimerWidget(),
                    ],
                  ),
                  addVerticalSpace(context.screenHeight * .03),

                  // Game

                  BlocBuilder<GameCubit, GameState>(
                    builder: (context, state) {
                      switch (state) {
                        case GameOngoingState():
                          return Column(
                            children: [
                              // Question number and Score

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Current question number
                                        
                                  Text('Q: ${state.currentIndex + 1}/${state.questions.length}'),

                                  // Score

                                  Text('Score:  ${state.score}/${state.answeredQuestions}'),
                                ],
                              ),
                              const Divider(),
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
                          );

                        case GameFinishedState():
                          return ResultCard(
                            score: state.score,
                            numberOfQuestions: state.numberOfQuestions,
                          );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
