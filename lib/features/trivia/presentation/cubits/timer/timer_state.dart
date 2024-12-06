import 'package:equatable/equatable.dart';

sealed class TimerState extends Equatable {
  final int remainingSeconds;

  const TimerState({required this.remainingSeconds});

  @override
  List<Object?> get props => [remainingSeconds];
}

final class TimerRunInProgress extends TimerState {
  const TimerRunInProgress({required super.remainingSeconds});
}

final class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(remainingSeconds: 0);
}
