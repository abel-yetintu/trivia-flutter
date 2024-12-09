import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivio/core/utils/extensions.dart';
import 'package:trivio/features/trivia/presentation/cubits/game/game_cubit.dart';
import 'package:trivio/features/trivia/presentation/cubits/game/game_state.dart';
import 'package:trivio/features/trivia/presentation/cubits/timer/timer_cubit.dart';
import 'package:trivio/features/trivia/presentation/cubits/timer/timer_state.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .02),
      child: BlocConsumer<TimerCubit, TimerState>(
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
          return SizedBox(
            width: context.screenWidth * .15,
            height: context.screenHeight * .07,
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: state.remainingSeconds / state.totalSeconds,
                ),
                Center(
                  child: Text("$minutesStr:$secondsStr"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
