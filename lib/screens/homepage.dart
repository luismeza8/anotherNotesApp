import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/screens/note_page.screen.dart';
import 'package:todo_app/widgets/noteCard.widget.dart';

import '../models/task.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  QuillController controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Text(
          'Your Notes App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Note'),
        icon: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TaskPage(),
          ),
        ).then(
          (value) => setState(() {}),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<List>(
              future: _dbHelper.getNotes(),
              builder: (context, snapshot) {
                return snapshot.data == null
                    ? Container()
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => goToNote(snapshot.data![index]),
                            child: TaskCard(
                              note: snapshot.data![index],
                              controller: controller,
                            ),
                          );
                        },
                      );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> goToNote(Notes note) async {
    String? content = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskPage(note: note),
      ),
    );

    if (content != null && content != 'Delete note') {
      setState(() {
        controller = QuillController(
            document: Document.fromJson(jsonDecode(content)),
            selection: const TextSelection.collapsed(offset: 0));
      });
    } else {
      setState(() {});
    }
  }
}
