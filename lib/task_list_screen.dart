import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'task_model.dart' show Task, mockTasks;
import 'add_task_screen.dart'; // Import AddTaskScreen

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = []; // List to store tasks

  @override
  void initState() {
    super.initState();
    tasks = mockTasks;
  }

  void markTaskCompleted(int taskId) {
    setState(() {
      int index = tasks.indexWhere((task) => task.id == taskId);
      tasks[index] = tasks[index].copyWith(isCompleted: !tasks[index].isCompleted);
    });
  }

  void deleteTask(int taskId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Build the confirmation dialog
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Close dialog on "No"
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true); // Close dialog on "Yes" and delete task
                setState(() {
                  tasks.removeWhere((task) => task.id == taskId);
                });
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }


  // Function to handle editing a task
  void editTask(Task task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddTaskScreen(isEdit: true, task: task)),
    );
    if (result != null) {
      // Update task in the list
      int index = tasks.indexWhere((t) => t.id == task.id);
      tasks[index] = result;
      setState(() {}); // Explicitly call setState to trigger UI update
    }
  }

  // Function to handle adding a new task
  void addNewTask(Task newTask) {
    setState(() {
      tasks.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks[index]; // Get the current Task object
          return Dismissible(
            key: Key(task.id.toString()), // Unique key for each task
            onDismissed: (direction) => deleteTask(task.id),
            child: GestureDetector(
              onLongPress: () => deleteTask(task.id), // Long press to delete
              child: ListTile(
                onTap: () => editTask(task), // Edit on tap
                title: Text(task.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.description),
                    Text(DateFormat('dd/MM/yyyy').format(task.dueDate)),
                  ],
                ),
                trailing: Checkbox(
                  value: task.isCompleted,
                  // Access isCompleted property of the Task object
                  onChanged: (newValue) => markTaskCompleted(task.id),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Handle adding a new task or editing an existing one
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddTaskScreen(isEdit: false)),
          );
          if (result != null) {
            // Handle adding a new task (result will be a new Task object)
            addNewTask(result);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
