import 'package:flutter/material.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Delete Task'),
        icon: Icon(Icons.delete),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Image(
                            image:
                                AssetImage('assets/images/back_arrow_icon.png'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
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
                            color: Color(0xFF211551),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a Description for the Task...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 24),
                    ),
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
            // Positioned(
            //   bottom: 24.0,
            //   right: 24.0,
            //   child: GestureDetector(
            //     onTap: (() => Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => const TaskPage()))),
            //     child: Container(
            //       height: 60,
            //       width: 60,
            //       decoration: BoxDecoration(
            //         color: const Color(0xFFFE3577),
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       child: const Image(
            //         image: AssetImage('assets/images/delete_icon.png'),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
