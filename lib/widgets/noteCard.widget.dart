import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:todo_app/models/notes.dart';

class TaskCard extends StatefulWidget {
  final Notes note;
  final QuillController controller;

  const TaskCard({Key? key, required this.note, required this.controller})
      : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    String? subtitle =
        Document.fromJson(jsonDecode(widget.note.description!)).toPlainText();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          widget.note.title ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}
