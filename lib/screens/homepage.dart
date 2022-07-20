import 'package:flutter/material.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/taskpage.dart';
import 'package:todo_app/widgets.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          color: const Color(0xFFF6F6F6),
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 32, top: 32),
                    child: const Image(
                        image: AssetImage('assets/images/logo.png')),
                  ),
                  Expanded(
                    child: FutureBuilder<List>(
                      future: _dbHelper.getTasks(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container();
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return TaskCard(
                                title: snapshot.data![index].title,
                              );
                            },
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: (() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TaskPage()))),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF7349FE),
                          Color(0xFF643FDB),
                        ],
                        begin: Alignment(0, -1),
                        end: Alignment(0, 1),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Image(
                      image: AssetImage('assets/images/add_icon.png'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
