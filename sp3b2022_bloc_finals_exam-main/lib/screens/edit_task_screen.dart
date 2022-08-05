import 'package:flutter/material.dart';
import '../blocs/bloc_imports.dart';
import '../models/task.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Text')),
      body: Container(color: Colors.amber),
    );
  }
}

class EditTaskWindow extends StatelessWidget {
  final Task oldTask;
  const EditTaskWindow({
    Key? key,
    required this.oldTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
    TextEditingController(text: oldTask.title);
    TextEditingController descriptionController =
    TextEditingController(text: oldTask.description);

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
              'Edit Task',
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
                controller: titleController,
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
                    'cancel',
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: const Text(
                    'Save',
                  ),
                  onPressed: () {
                    var editedTask = Task(
                      id: oldTask.id,
                      title: titleController.text,
                      description: descriptionController.text,
                      isDone: false,
                      isFavourite: oldTask.isFavourite,
                      date: DateTime.now().toString(),
                    );
                    context.read<TasksBloc>().add(EditTask(
                      oldTask: oldTask,
                      newTask: editedTask,
                    ));
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
