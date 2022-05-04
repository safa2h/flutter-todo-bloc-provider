import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo4/data/data.dart';
import 'package:todo4/data/repo/repository.dart';

part 'tasklist_event.dart';
part 'tasklist_state.dart';

class TaskListBloc extends Bloc<TasklistEvent, TasklistState> {
  final Repository<TaskEntity> repository;

  TaskListBloc(this.repository) : super(TaskListInitial()) {
    on<TasklistEvent>((event, emit) async {
      emit(TaskListLoading());
      if (event is TaskListSearch || event is TaskListStart) {
        String searchterm;
        if (event is TaskListSearch) {
          searchterm = event.searchKeyword;
        } else {
          searchterm = '';
        }

        try {
          final items = await repository.getAll(searchKeyword: searchterm);
          if (items.isNotEmpty) {
            emit(TaskListsucceess(items));
          } else {
            emit(TaskListEmpty());
          }
        } catch (e) {
          emit(TaskListError(e.toString()));
        }
      } else if (event is TaskListDeleteAll) {
        repository.deleteAll();
        emit(TaskListEmpty());
      }
    });
  }
}
