import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/models/notes.dart';

import 'package:flutter_quill/flutter_quill.dart' as quill;

// ignore: must_be_immutable
class TaskPage extends StatefulWidget {
  late final Notes? note;

  TaskPage({Key? key, this.note}) : super(key: key);

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

    if (widget.note?.description != null) {
      controller = quill.QuillController(
        document: quill.Document.fromJson(
          jsonDecode(widget.note!.description!),
        ),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      controller = quill.QuillController.basic();
    }

    String? noteDescription;
    String? noteTitle;
    List<String> popUpMenuItems = ['Delete note'];

    return Scaffold(
      appBar: AppBar(
        // leading:
        //     IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return popUpMenuItems.map(
                (choice) {
                  return PopupMenuItem(
                    onTap: () => deleteNote(),
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
            hintText: 'Enter Note Title',
            border: InputBorder.none,
          ),
          controller: widget.note != null
              ? TextEditingController(text: widget.note!.title)
              : TextEditingController(text: ''),
          onChanged: (value) async {
            if (value.isNotEmpty || value != '') noteTitle = value;
          },
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          DatabaseHelper _dbHelper = DatabaseHelper();

          noteDescription = jsonEncode(controller!.document.toDelta().toJson());

          if (widget.note == null) {
            Notes _newTask =
                Notes(title: noteTitle, description: noteDescription!);
            _dbHelper.insertNote(_newTask);
          } else {
            widget.note!.title = noteTitle ?? widget.note!.title;
            widget.note!.description = noteDescription;
            _dbHelper.updateNote(widget.note!);
          }

          Navigator.pop(context, noteDescription);
        },
        label: const Text('Save Note'),
        icon: const Icon(Icons.save),
      ),
      body: Column(
        children: [
          getToolBar(controller),
          getEditor(controller),
        ],
      ),
    );
  }

  void deleteNote() {
    DatabaseHelper _dbHelper = DatabaseHelper();
    _dbHelper.deleteNote(widget.note!);

    Navigator.pop(context);
  }

  quill.QuillToolbar getToolBar(quill.QuillController controller) {
    return quill.QuillToolbar.basic(
      controller: controller,
      multiRowsDisplay: false,
      toolbarIconSize: 24,
    );
  }

  Widget getEditor(quill.QuillController controller) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: quill.QuillEditor(
          controller: controller,
          scrollController: ScrollController(),
          scrollable: true,
          focusNode: FocusNode(),
          autoFocus: false,
          readOnly: false,
          placeholder: 'Add your note here.',
          expands: false,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
