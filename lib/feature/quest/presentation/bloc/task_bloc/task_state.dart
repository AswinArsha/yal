import 'package:yalgamers/feature/quest/data/model/task_model.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final TaskModel task;

  TaskLoaded(this.task);
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}
