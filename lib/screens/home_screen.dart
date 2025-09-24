import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> _tasks = [];

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedPriority = "Low";

  void _toggleComplete(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  void _addTask() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Add New Task",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: "Description"),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      _selectedDate == null
                          ? "No date chosen"
                          : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                    ),
                    const Spacer(),
                    TextButton(
                      child: const Text("Pick Date"),
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                    )
                  ],
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _selectedPriority,
                  items: ["Low", "Medium", "High"]
                      .map((p) =>
                          DropdownMenuItem(value: p, child: Text(p)))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedPriority = val!;
                    });
                  },
                  decoration: const InputDecoration(labelText: "Priority"),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Add Task"),
                  onPressed: () {
                    if (_titleController.text.isEmpty) return;

                    setState(() {
                      _tasks.add(Task(
                        title: _titleController.text,
                        description: _descController.text,
                        dueDate: _selectedDate,
                        priority: _selectedPriority,
                      ));
                    });

                    _titleController.clear();
                    _descController.clear();
                    _selectedDate = null;
                    _selectedPriority = "Low";

                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My To-Do List"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: _tasks.isEmpty
          ? const Center(
              child: Text(
                "No tasks yet. Add one!",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (ctx, index) {
                final task = _tasks[index];
                return TaskItem(
                  task: task,
                  onToggleComplete: () => _toggleComplete(task),
                  onDelete: () => _deleteTask(task),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}

