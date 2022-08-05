part of my_tasks_lab;

class TasksState extends Equatable {
  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> favouriteTasks;
  final List<Task> trashTasks;

  const TasksState({
    this.pendingTasks = const <Task>[],
    this.completedTasks = const <Task>[],
    this.favouriteTasks = const <Task>[],
    this.trashTasks = const <Task>[],
  });

  @override
  List<Object> get props => [
    pendingTasks,
    completedTasks,
    favouriteTasks,
    trashTasks,
  ];

  Map<String, dynamic> toMap() {
    return {
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList(),
      'favouriteTasks': favouriteTasks.map((x) => x.toMap()).toList(),
      'trashTasks': trashTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      pendingTasks:
      List<Task>.from(map['pendingTasks']?.map((x) => Task.fromMap(x))),
      completedTasks:
      List<Task>.from(map['completedTasks']?.map((x) => Task.fromMap(x))),
      favouriteTasks:
      List<Task>.from(map['favouriteTasks']?.map((x) => Task.fromMap(x))),
      trashTasks:
      List<Task>.from(map['trashTasks']?.map((x) => Task.fromMap(x))),
    );
  }
}
