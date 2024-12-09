import 'package:equatable/equatable.dart';

sealed class TimerState extends Equatable {
  final int remainingSeconds;
  final int totalSeconds;

  const TimerState({required this.remainingSeconds, required this.totalSeconds});

  @override
  List<Object?> get props => [remainingSeconds];
}

final class TimerRunInProgress extends TimerState {
  const TimerRunInProgress({required super.remainingSeconds, required super.totalSeconds});
}

final class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(remainingSeconds: 0, totalSeconds: 0);
}
