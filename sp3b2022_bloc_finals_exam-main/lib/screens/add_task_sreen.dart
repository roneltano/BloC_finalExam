import 'package:flutter/material.dart';
import '../blocs/bloc_imports.dart';
import '../services/guid_gen.dart';
import '../models/task.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Container(
      color: Theme.of(context).dividerColor,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                autofocus: true,
                // textAlign: TextAlign.center,
                minLines: 1,
                maxLines: 2,
                maxLength: 100,
                keyboardType: TextInputType.multiline,
                controller: nameController,
                decoration: const InputDecoration(
                  // hintText: 'insert task',
                  label: Text('Title'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            TextField(
              // autofocus: true,
              // textAlign: TextAlign.center,
              minLines: 1,
              maxLines: 6,
              maxLength: 5000,
              keyboardType: TextInputType.multiline,
              controller: descriptionController,
              decoration: const InputDecoration(
                label: Text('Description'),
                // hintText: 'insert description',
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text(
                    'Cancel',
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: const Text(
                    'Add',
                  ),
                  onPressed: () {
                    var task = Task(
                      id: GUIDGen.generate(),
                      title: nameController.text,
                      description: descriptionController.text,
                      date: DateTime.now().toString(),
                    );
                    context.read<TasksBloc>().add(AddTask(task: task));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
