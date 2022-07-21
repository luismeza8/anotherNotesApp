import 'package:flutter/material.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Enter Task Title',
            border: InputBorder.none,
          ),
          onSubmitted: (value) async {
            if (value.isNotEmpty) {
              DatabaseHelper _dbHelper = DatabaseHelper();

              Task _newTask = Task(title: value);

              _dbHelper.insertStask(_newTask);
            }
          },
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          (value) async {
            if (value.isNotEmpty) {
              DatabaseHelper _dbHelper = DatabaseHelper();

              Task _newTask = Task(title: value);

              _dbHelper.insertStask(_newTask);
            }
          };
        },
        label: const Text('Save Note'),
        icon: const Icon(Icons.save),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Add a Description for the Task...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 24),
                    ),
                    onSubmitted: (value) async {
                      if (value.isNotEmpty) {}
                    },
                  ),
                ),
                const ToDoWidget(
                  title: 'First task',
                  isDone: true,
                ),
                const ToDoWidget(
                  isDone: false,
                ),
                const ToDoWidget(
                  isDone: true,
                ),
                const ToDoWidget(
                  isDone: false,
                ),
                const ToDoWidget(
                  isDone: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
