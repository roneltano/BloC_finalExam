import 'package:flutter/material.dart';

import '../blocs/bloc_imports.dart';
import '../widgets/tasks_list.dart';

class FavouriteTasksScreen extends StatelessWidget {
  const FavouriteTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Chip(
            label: Text(
              '${state.favouriteTasks.length} tasks',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TasksList(
                tasks: state.favouriteTasks,
              ),
            ),
          ),
        ],
        // ),
      );
    });
  }
}
