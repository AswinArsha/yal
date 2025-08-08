part of 'project_bloc.dart';

@immutable
sealed class ProjectState {}

final class ProjectInitial extends ProjectState {}

final class ProjectLoadingState extends ProjectState {}

final class ProjectSuccessState extends ProjectState {
  final List<Project> projects;

  ProjectSuccessState(this.projects);
}

final class ProjectFailureState extends ProjectState {
  final String error;

  ProjectFailureState(this.error);
}
