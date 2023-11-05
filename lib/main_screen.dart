import 'package:flutter/material.dart';
import 'package:counter_app/first_section.dart';
import 'package:counter_app/second_section.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> screens = [const FirstSection(), const SecondSection()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Session 5 Assignments - Navigation')),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate), label: "Counter"),
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add), label: "Screen Generator"),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
