import 'package:flutter/material.dart';

import '../models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback likeCallback;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback restoreCallback;
  final VoidCallback editTaskCallback;

  const PopupMenu({
    Key? key,
    required this.task,
    required this.likeCallback,
    required this.cancelOrDeleteCallback,
    required this.restoreCallback,
    required this.editTaskCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: PopupMenuButton(
        itemBuilder: task.isCancelled == false
            ? (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        editTaskCallback();
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                      autofocus: true,
                    ),
                    onTap: null,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        icon: task.isFavourite == false
                            ? const Icon(Icons.bookmark_add_outlined)
                            : const Icon(Icons.bookmark_remove),
                        label: task.isFavourite == false
                            ? const Text(
                                'Add to \nBookmarks',
                                textAlign: TextAlign.center,
                              )
                            : const Text(
                                'Remove from \nBookmarks',
                                textAlign: TextAlign.center,
                              )),
                    onTap: likeCallback,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete_sharp),
                      label: const Text('Delete'),
                    ),
                    onTap: cancelOrDeleteCallback,
                  ),
                ]
            : (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Delete permanently'),
                    ),
                    onTap: cancelOrDeleteCallback,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.restore_from_trash),
                      label: const Text('Restore'),
                    ),
                    onTap: restoreCallback,
                  ),
                ],
      ),
    );
  }
}
