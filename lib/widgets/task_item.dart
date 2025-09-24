import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleComplete;
  final VoidCallback onDelete;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onToggleComplete,
    required this.onDelete,
  }) : super(key: key);

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "high":
        return Colors.redAccent;
      case "medium":
        return Colors.orangeAccent;
      case "low":
        return Colors.green;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isCompleted ? Colors.green : Colors.grey,
          size: 28,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description.isNotEmpty)
              Text(
                task.description,
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.blueGrey),
                const SizedBox(width: 4),
                Text(
                  task.dueDate != null
                      ? "${task.dueDate!.day}/${task.dueDate!.month}/${task.dueDate!.year}"
                      : "No due date",
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 12),
                Chip(
                  label: Text(task.priority),
                  backgroundColor: _getPriorityColor(task.priority).withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: _getPriorityColor(task.priority),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: onToggleComplete,
      ),
    );
  }
}

