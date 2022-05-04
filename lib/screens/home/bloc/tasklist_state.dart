part of 'tasklist_bloc.dart';

@immutable
abstract class TasklistState {}

class TaskListInitial extends TasklistState {}

class TaskListLoading extends TasklistState {}

class TaskListsucceess extends TasklistState {
  final List<TaskEntity> items;

  TaskListsucceess(this.items);
}

class TaskListEmpty extends TasklistState {}

class TaskListError extends TasklistState {
  final String errorMessage;

  TaskListError(this.errorMessage);
}
