import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/models/task.dart';

import 'package:flutter_quill/flutter_quill.dart' as quill;

// ignore: must_be_immutable
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
    quill.QuillController? controller;

    if (widget.task?.description != null) {
      controller = quill.QuillController(
        document:
            quill.Document.fromJson(jsonDecode(widget.task!.description!)),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      controller = quill.QuillController.basic();
    }

    String? noteDescription;
    String? noteTitle;
    List<String> items = ['Delete note'];

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return items.map(
                (choice) {
                  return PopupMenuItem(
                    onTap: () {
                      DatabaseHelper _dbHelper = DatabaseHelper();
                      _dbHelper.deleteNote(widget.task!);

                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.delete),
                        ),
                        Text(choice)
                      ],
                    ),
                    value: choice,
                  );
                },
              ).toList();
            },
          ),
        ],
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

          noteDescription = jsonEncode(controller!.document.toDelta().toJson());

          Task _newTask = Task(title: noteTitle, description: noteDescription!);
          _dbHelper.insertStask(_newTask);

          Navigator.pop(context, noteDescription);
        },
        label: const Text('Save Note'),
        icon: const Icon(Icons.save),
      ),
      body: Column(
        children: [
          quill.QuillToolbar.basic(
            controller: controller,
            multiRowsDisplay: false,
            toolbarIconSize: 24,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: quill.QuillEditor.basic(
                controller: controller,
                readOnly: false,
              ),
            ),
          )
        ],
      ),
    );
  }
}
