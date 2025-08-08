// save_task_state.dart

abstract class SaveTaskState {}

class SaveTaskInitial extends SaveTaskState {}

class SaveTaskLoading extends SaveTaskState {}

class SaveTaskSuccess extends SaveTaskState {
  final Map<String, dynamic> response;

  SaveTaskSuccess(this.response);
}

class SaveTaskFailure extends SaveTaskState {
  final String error;

  SaveTaskFailure(this.error);
}
