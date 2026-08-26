import 'package:equatable/equatable.dart';

abstract class CreateTaskState extends Equatable {
  const CreateTaskState();

  @override
  List<Object?> get props => [];
}

class CreateTaskInitial extends CreateTaskState {}

class CreateTaskLoading extends CreateTaskState {}

class CreateTaskSuccess extends CreateTaskState {}

class CreateTaskFailure extends CreateTaskState {
  final String message;

  const CreateTaskFailure(this.message);

  @override
  List<Object?> get props => [message];
}
