abstract class SaveTaskEvent {}

class SaveTaskRequested extends SaveTaskEvent {
  final String taskId;
  final  username;

  SaveTaskRequested({required this.taskId,  this.username});
}
