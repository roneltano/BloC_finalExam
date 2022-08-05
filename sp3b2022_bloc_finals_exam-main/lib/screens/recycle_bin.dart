import 'package:flutter/material.dart';
import '../widgets/tasks_list.dart';
import '../blocs/bloc_imports.dart';
import 'my_drawer.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        child: TextButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.delete_forever),
                          label: const Text('Delete all tasks'),
                        ),
                        onTap: () => context
                            .read<TasksBloc>()
                            .add(DeleteAllTasks())),
                  ])
            ],
          ),
          drawer: const MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Chip(
                label: Text(
                  '${state.trashTasks.length} Tasks',
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
                    tasks: state.trashTasks,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    // },
    // );
  }
}
