import 'package:equatable/equatable.dart';

abstract class ActiveTaskState extends Equatable {
  const ActiveTaskState();

  @override
  List<Object?> get props => [];
}

class ActiveTaskInitial extends ActiveTaskState {}

class ActiveTaskLoading extends ActiveTaskState {}

class ActiveTaskCompleted extends ActiveTaskState {
  final int earnedCoins;

  const ActiveTaskCompleted(this.earnedCoins);

  @override
  List<Object?> get props => [earnedCoins];
}

class ActiveTaskError extends ActiveTaskState {
  final String message;

  const ActiveTaskError(this.message);

  @override
  List<Object?> get props => [message];
}
