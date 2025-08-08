

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalgamers/feature/quest/data/model/project_model.dart';
import 'package:yalgamers/feature/quest/data/repository/project_repo.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {

  ProjectBloc() : super(ProjectInitial()) {
    on<LoadProjects>(_onLoadProjects);
  }

  Future<void> _onLoadProjects(
    LoadProjects event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectLoadingState());

    try {
      final projects = await ProjectService.fetchProjects(); // Use ProjectService directly
      emit(ProjectSuccessState(projects));
    } catch (e) {
      emit(ProjectFailureState(e.toString()));
    }
  }
}