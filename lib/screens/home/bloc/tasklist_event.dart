part of 'tasklist_bloc.dart';

@immutable
abstract class TasklistEvent {}

class TaskListStart extends TasklistEvent {}

class TaskListDeleteAll extends TasklistEvent {}

class TaskListSearch extends TasklistEvent {
  final String searchKeyword;

  TaskListSearch(this.searchKeyword);
}
