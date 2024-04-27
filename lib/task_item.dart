import 'package:flutter/material.dart';
import 'task_model.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(bool?) onToggleCompleted;
  final VoidCallback onDelete;

  TaskItem({
    required this.task,
    required this.onToggleCompleted,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: onToggleCompleted,
      ),
      onLongPress: onDelete,
    );
  }
}
