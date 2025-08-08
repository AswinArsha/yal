import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalgamers/feature/quest/data/repository/task_details_repo.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc({required this.repository}) : super(TaskInitial()) {
    on<LoadTask>(_onLoadTask);
  }

  Future<void> _onLoadTask(LoadTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    try {
      final task = await repository.fetchTaskById(event.taskId);
      emit(TaskLoaded(task));
    } catch (e) {
      emit(TaskError('Error loading task: ${e.toString()}'));
    }
  }
}
