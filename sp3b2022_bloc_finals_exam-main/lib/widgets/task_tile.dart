import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';
import 'popup_menu.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool?) checkboxCallback;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeCallback;
  final VoidCallback restoreCallback;
  final VoidCallback editTaskCallback;

  const TaskTile({
    Key? key,
    required this.task,
    required this.checkboxCallback,
    required this.cancelOrDeleteCallback,
    required this.likeCallback,
    required this.restoreCallback,
    required this.editTaskCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                IconButton(
                  onPressed: null,
                  icon: task.isFavourite == false
                      ? const Icon(Icons.star_outline)
                      : const Icon(Icons.star),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : null,
                            fontSize: 18),
                      ),
                      Text(DateFormat.yMMMd()
                          .add_Hms()
                          .format(DateTime.parse(task.date))
                          .toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                // activeColor: Theme.of(context).colorScheme.primary,
                value: task.isDone,
                onChanged: task.isCancelled == false ? checkboxCallback : null,
              ),
              PopupMenu(
                task: task,
                likeCallback: likeCallback,
                cancelOrDeleteCallback: cancelOrDeleteCallback,
                restoreCallback: restoreCallback,
                editTaskCallback: editTaskCallback,
              )
            ],
          )
        ],
      ),
    );
  }
}

// ListTile(
//   onLongPress: longPressCallback,
//   title: SelectableText(
//     taskTitle,
//     toolbarOptions: const ToolbarOptions(
//       copy: true,
//       selectAll: true,
//       cut: true,
//     ),
//     style: TextStyle(
//         decoration: isChecked ? TextDecoration.lineThrough : null),
//   ),
//   trailing: Checkbox(
//     activeColor: Theme.of(context).colorScheme.primary,
//     value: isChecked,
//     onChanged: checkboxCallback,
//   ),
// );
