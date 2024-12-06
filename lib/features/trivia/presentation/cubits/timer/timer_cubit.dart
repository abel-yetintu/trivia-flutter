import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivio/features/trivia/domain/entities/ticker.dart';
import 'package:trivio/features/trivia/presentation/cubits/timer/timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;

  TimerCubit({required int seconds, required Ticker ticker})
      : _ticker = ticker,
        super((TimerRunInProgress(remainingSeconds: seconds))) {
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: seconds).listen((remaining) {
      if (remaining > 0) {
        emit(TimerRunInProgress(remainingSeconds: remaining));
      } else {
        emit(const TimerRunComplete());
      }
    });
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
