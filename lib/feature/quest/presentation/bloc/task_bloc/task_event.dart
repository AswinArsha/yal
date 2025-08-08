abstract class TaskEvent {}

class LoadTask extends TaskEvent {
  final String taskId;

  LoadTask({required this.taskId});
}
