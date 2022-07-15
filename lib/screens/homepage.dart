import 'package:flutter/material.dart';
import 'package:todo_app/screens/taskpage.dart';
import 'package:todo_app/widgets.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
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
                    child: ListView(
                      children: const [
                        TaskCard(
                          title: 'Get Started!',
                          description:
                              'Hello User, Welcome to Yes, Another ToDo App',
                        ),
                        TaskCard(),
                        TaskCard(),
                        TaskCard(),
                        TaskCard(),
                        TaskCard(),
                      ],
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
