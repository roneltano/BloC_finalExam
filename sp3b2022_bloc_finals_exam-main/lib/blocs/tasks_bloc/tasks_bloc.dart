library my_tasks_lab;

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super((const TasksState())) {
    on<AddTask>(_onAddTodo);
    on<UpdateTask>(_onUpdateTodo);
    on<CancelTask>(_onCancelTask);
    on<DeleteTask>(_onDeleteTask);
    on<DeleteAllTasks>(_onDeleteAllTask);
    on<LikeOrDislikeTask>(_onLikeOrDislikeTask);
    on<RestoreTask>(_onRestoreTask);
    on<EditTask>(_onEditTask);
  }
  void _onAddTodo(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        pendingTasks: List.from(state.pendingTasks)..insert(0, event.task),
        completedTasks: state.completedTasks,
        favouriteTasks: state.favouriteTasks,
        trashTasks: state.trashTasks,
      ),
    );
  }

  void _onUpdateTodo(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favouriteTasks = state.favouriteTasks;
    if (task.isDone == false) {
      if (task.isFavourite == false) {
        //bu joyda prosta remove qibo'midi
        pendingTasks = List.from(pendingTasks)..remove(task);

        completedTasks.insert(0, task.copyWith(isDone: true));
        //copyWith bilan qilsa bo'ladi.
      } else {
        var taskIndex = favouriteTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks.insert(0, task.copyWith(isDone: true));
        favouriteTasks = List.from(favouriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: true));
      }
    } else {
      if (task.isFavourite == false) {
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
      } else {
        var taskIndex = favouriteTasks.indexOf(task);
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
        favouriteTasks = List.from(favouriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: false));
      }
    }
    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favouriteTasks: favouriteTasks,
      trashTasks: state.trashTasks,
    ));
  }

  void _onLikeOrDislikeTask(LikeOrDislikeTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favouriteTasks = state.favouriteTasks;
    if (event.task.isDone == false) {
      if (event.task.isFavourite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: true));
        favouriteTasks.insert(0, event.task.copyWith(isFavourite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: false));
        favouriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavourite == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: true));
        favouriteTasks.insert(0, event.task.copyWith(isFavourite: true));
      } else {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: false));
        favouriteTasks.remove(event.task);
      }
    }
    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favouriteTasks: favouriteTasks,
      trashTasks: state.trashTasks,
    ));
  }

  void _onCancelTask(CancelTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(
      TasksState(
        trashTasks: List.from(state.trashTasks)
          ..insert(0, event.task.copyWith(isCancelled: true)),
        pendingTasks: state.pendingTasks..remove(event.task),
        completedTasks: state.completedTasks..remove(event.task),
        favouriteTasks: state.favouriteTasks..remove(event.task),
      ),
    );

    // List<Task> trashTasks = state.trashTasks;
    // for (var task in state.pendingTasks) {
    //   if (task.id == event.task.id) {
    //     trashTasks.insert(0, task.copyWith(isCancelled: true));
    //     emit(TasksState(
    //       pendingTasks: List.from(state.pendingTasks)..remove(event.task),
    //       completedTasks: state.completedTasks,
    //       favouriteTasks: List.from(state.favouriteTasks)..remove(event.task),
    //       trashTasks: trashTasks,
    //     ));
    //     return;
    //   }
    // }
    // for (var task in state.completedTasks) {
    //   if (task.id == event.task.id) {
    //     trashTasks.insert(0, task.copyWith(isCancelled: true));
    //     emit(TasksState(
    //       pendingTasks: state.pendingTasks,
    //       completedTasks: List.from(state.completedTasks)..remove(event.task),
    //       favouriteTasks: List.from(state.favouriteTasks)..remove(event.task),
    //       trashTasks: trashTasks,
    //     ));
    //     return;
    //   }
    // }
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        trashTasks: List.from(state.trashTasks)..remove(event.task),
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favouriteTasks: state.favouriteTasks,
      ),
    );
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favouriteTasks = state.favouriteTasks;
    if (event.oldTask.isFavourite == true) {
      favouriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }

    emit(
      TasksState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTasks: state.completedTasks..remove(event.oldTask),
        favouriteTasks: favouriteTasks,
        trashTasks: state.trashTasks,
      ),
    );
  }

  void _onDeleteAllTask(DeleteAllTasks event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        trashTasks: const [],
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favouriteTasks: state.favouriteTasks,
      ),
    );
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        trashTasks: List.from(state.trashTasks)..remove(event.task),
        pendingTasks: List.from(state.pendingTasks)
          ..insert(
              0,
              event.task.copyWith(
                isCancelled: false,
                isDone: false,
                isFavourite: false,
              )),
        completedTasks: state.completedTasks,
        favouriteTasks: state.favouriteTasks,
      ),
    );
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
