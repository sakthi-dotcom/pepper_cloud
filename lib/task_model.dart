
class Task {
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });

  // Factory constructor to create Task from JSON
  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    dueDate: DateTime.parse(json['dueDate']),
    isCompleted: json['isCompleted'] ?? false,
  );

  // Method to convert Task object to JSON format
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'dueDate': dueDate.toIso8601String(),
    'isCompleted': isCompleted,
  };

  // Method to create a copy of the Task object with updated properties
  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
  }) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        dueDate: dueDate ?? this.dueDate,
        isCompleted: isCompleted ?? this.isCompleted,
      );
}



// Replace this with your actual API call
final List<Task> mockTasks = [
  Task(
    id: 1,
    title: 'Buy groceries',
    description: 'Milk, bread, eggs',
    dueDate: DateTime.now().add(Duration(days: 2)),
    isCompleted: false,
  ),
  Task(
    id: 2,
    title: 'Finish project report',
    description: 'Due Monday',
    dueDate: DateTime(2024, 05, 06),
    isCompleted: false,
  ),
  Task(
    id: 3,
    title: 'Go for a run',
    description: '30 minutes',
    dueDate: DateTime.now().add(Duration(days: 1)),
    isCompleted: false,
  ),
  Task(
    id: 4,
    title: 'Call dentist',
    description: 'Schedule appointment',
    dueDate: DateTime(2024, 05, 10),
    isCompleted: false,
  ),
];
