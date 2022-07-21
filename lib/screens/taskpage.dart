import 'package:flutter/material.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets.dart';

class TaskPage extends StatefulWidget {
  final Task? task;

  const TaskPage({Key? key, this.task}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? noteDescription;
    String? noteTitle;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Enter Task Title',
            border: InputBorder.none,
          ),
          controller: widget.task != null
              ? TextEditingController(text: widget.task!.title ?? '')
              : TextEditingController(text: ''),
          onChanged: (value) async {
            if (value.isNotEmpty) {
              noteTitle = value;
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
          DatabaseHelper _dbHelper = DatabaseHelper();

          Task _newTask = Task(title: noteTitle, description: noteDescription);

          _dbHelper.insertStask(_newTask);
          Navigator.pop(context);
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
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    scrollController: ScrollController(),
                    decoration: const InputDecoration(
                      hintText: 'Add a Description for the Task...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 24),
                    ),
                    initialValue: widget.task != null
                        ? widget.task!.description ?? ''
                        : '',
                    onChanged: (value) async {
                      if (value.isNotEmpty) {
                        noteDescription = value;
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
