import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskStorage {
  static const String _key = "tasks";

  // Save tasks
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((t) => t.toMap()).toList();
    prefs.setString(_key, jsonEncode(tasksJson));
  }

  // Load tasks
  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString(_key);
    if (tasksString == null) return [];
    final List decoded = jsonDecode(tasksString);
    return decoded.map((map) => Task.fromMap(map)).toList();
  }
}

