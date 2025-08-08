// blocs/save_task_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalgamers/feature/quest/data/repository/complete_task_repo.dart';
import 'save_task_event.dart';
import 'save_task_state.dart';

class SaveTaskBloc extends Bloc<SaveTaskEvent, SaveTaskState> {
  final SaveTaskService taskService;

  SaveTaskBloc({required this.taskService}) : super(SaveTaskInitial()) {
    on<SaveTaskRequested>(_onSaveTaskRequested);
  }

  Future<void> _onSaveTaskRequested(
    SaveTaskRequested event,
    Emitter<SaveTaskState> emit,
  ) async {
    emit(SaveTaskLoading());

    try {
      final response = await taskService.saveTask(
        taskId: event.taskId,
        username: event.username,
      );
      emit(SaveTaskSuccess(response));
    } catch (e) {
      emit(SaveTaskFailure(e.toString()));
    }
  }
}
