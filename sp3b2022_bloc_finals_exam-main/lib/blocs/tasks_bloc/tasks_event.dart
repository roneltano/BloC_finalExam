part of my_tasks_lab;



abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TasksEvent {
  final Task task;
  const AddTask({required this.task});

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TasksEvent {
  final Task task;
  const UpdateTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class CancelTask extends TasksEvent {
  final Task task;
  const CancelTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TasksEvent {
  final Task task;
  const DeleteTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class EditTask extends TasksEvent {
  final Task oldTask;
  final Task newTask;
  const EditTask({
    required this.oldTask,
    required this.newTask,
  });

  @override
  List<Object> get props => [oldTask, newTask];
}

class DeleteAllTasks extends TasksEvent {}

class LikeOrDislikeTask extends TasksEvent {
  final Task task;
  const LikeOrDislikeTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class RestoreTask extends TasksEvent {
  final Task task;
  const RestoreTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

// class LikePendingTask extends TodosEvent {
//   final Task task;
//   const LikePendingTask({
//     required this.task,
//   });

//   @override
//   List<Object> get props => [task];
// }

// class DislikePendingTask extends TodosEvent {
//   final Task task;
//   const DislikePendingTask({
//     required this.task,
//   });

//   @override
//   List<Object> get props => [task];
// }

// class LikeCompletedTask extends TodosEvent {
//   final Task task;
//   const LikeCompletedTask({
//     required this.task,
//   });

//   @override
//   List<Object> get props => [task];
// }

// class DislikeCompletedTask extends TodosEvent {
//   final Task task;
//   const DislikeCompletedTask({
//     required this.task,
//   });

//   @override
//   List<Object> get props => [task];
// }
