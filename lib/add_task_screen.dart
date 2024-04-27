import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'task_model.dart' show Task;

class AddTaskScreen extends StatefulWidget {
  final bool isEdit; // Flag to indicate edit mode
  final Task? task; // Optional Task object for editing

  const AddTaskScreen({Key? key, this.isEdit = false, this.task}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _dueDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Pre-fill fields if editing an existing task
    if (widget.isEdit && widget.task != null) {
      _title = widget.task!.title;
      _description = widget.task!.description;
      _dueDate = widget.task!.dueDate;
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (widget.isEdit && widget.task != null) {
        // Update existing task
        final updatedTask = Task(
          id: widget.task!.id, // Maintain original ID
          title: _title,
          description: _description,
          dueDate: _dueDate,
          isCompleted: widget.task!.isCompleted, // Preserve completion state
        );
        Navigator.pop(context, updatedTask); // Pass updated task back
      } else {
        // Create a new task
        final newTask = Task(
          id: DateTime.now().millisecondsSinceEpoch, // Generate new ID
          title: _title,
          description: _description,
          dueDate: _dueDate,
          isCompleted: false,
        );
        Navigator.pop(context, newTask); // Pass new task back
      }
    }
  }

  void _selectDueDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _dueDate) {
      setState(() {
        _dueDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Task' : 'Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onSaved: (value) => _description = value!,
              ),
              Row(
                children: [
                  Text('Due Date:'),
                  TextButton(
                    onPressed: () => _selectDueDate(context),
                    child: Text(DateFormat('dd/MM/yyyy').format(_dueDate)),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _saveTask,
                child: Text(widget.isEdit ? 'Update Task' : 'Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
