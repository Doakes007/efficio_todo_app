class Task {
  String title;
  String description;
  String priority; // Low, Medium, High
  DateTime? dueDate;
  bool isCompleted;

  Task({
    required this.title,
    this.description = "",
    this.priority = "Low",
    this.dueDate,
    this.isCompleted = false,
  });

  // Convert Task to Map (for storage)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'dueDate': dueDate?.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  // Create Task from Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'] ?? "",
      priority: map['priority'] ?? "Low",
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}

