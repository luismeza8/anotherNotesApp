import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final String? title;
  final String? description;

  const TaskCard({Key? key, this.title, this.description}) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.title ?? 'Unnamed Note',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(widget.description ?? ''),
    );
  }
}

class ToDoWidget extends StatelessWidget {
  final String? title;
  final bool isDone;

  const ToDoWidget({Key? key, this.title, required this.isDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isDone ? const Color(0xFF7349FE) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isDone
                  ? null
                  : Border.all(
                      width: 1.5,
                    ),
            ),
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(right: 12),
            child:
                const Image(image: AssetImage('assets/images/check_icon.png')),
          ),
          Text(
            title ?? 'ToDo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
