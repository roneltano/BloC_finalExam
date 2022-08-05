import 'package:flutter/material.dart';
import '../blocs/bloc_imports.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                child: Text("Ronel's Tab",
                    style: Theme.of(context).textTheme.headline5),
              ),
            ),
            BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
                child: ListTile(
                  leading: const Icon(Icons.folder_special),
                  title: const Text('My Tasks'),
                  trailing: Text(
                      '${state.pendingTasks.length} | ${state.completedTasks.length}'),
                ),
              );
            }),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/recycle_bin');
                  },
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Bin'),
                    trailing: Text('${state.trashTasks.length}'),
                  ),
                );
              },
            ),
            const Divider(),
            const Text(
              'Dark Mode',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                var _stateValue = state.switchValue;
                return Switch(
                  value: _stateValue,
                  onChanged: (newValue) {
                    newValue
                        ? context.read<SwitchBloc>().add(SwitchOnEvent())
                        : context.read<SwitchBloc>().add(SwitchOffEvent());
                  },
                );
              },
            ),
          ],
        ),
      ),
      // },
    );
    // );
  }
}
