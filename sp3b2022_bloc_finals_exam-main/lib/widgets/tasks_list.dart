import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/tasks_bloc/tasks_bloc.dart';
import '../blocs/bloc_imports.dart';
import '../models/task.dart';
import '../screens/edit_task_screen.dart';
import '../widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasks;

  const TasksList({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  void _cancelOrDeleteCallback(BuildContext ctx, Task task) {
    task.isCancelled == false
        ? ctx.read<TasksBloc>().add(CancelTask(task: task))
        : ctx.read<TasksBloc>().add(DeleteTask(task: task));
  }

  void _editTaskCallback(BuildContext ctx, Task task) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditTaskWindow(oldTask: task),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        // behavior: HitTestBehavior.translucent,
        child: ExpansionPanelList.radio(
          elevation: 3,
          children: tasks
              .map(
                (task) => ExpansionPanelRadio(
                  headerBuilder: (context, isOpen) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TaskTile(
                      task: task,
                      checkboxCallback: (checkboxState) {
                        context.read<TasksBloc>().add(UpdateTask(task: task));
                      },
                      cancelOrDeleteCallback: () =>
                          _cancelOrDeleteCallback(context, task),
                      likeCallback: () => context
                          .read<TasksBloc>()
                          .add(LikeOrDislikeTask(task: task)),
                      restoreCallback: () => context
                          .read<TasksBloc>()
                          .add(RestoreTask(task: task)),
                      editTaskCallback: () => _editTaskCallback(context, task),
                    ),
                  ),
                  body: ListTile(
                    title: SelectableText.rich(TextSpan(children: [
                      const TextSpan(
                        text: 'Task:\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: task.title,
                      ),
                      const TextSpan(
                        text: '\n\nDescription:\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: task.description,
                      ),
                    ])),
                  ),
                  value: Text(task.id),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
