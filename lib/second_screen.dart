import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the second screen.
          Navigator.pop(context);
        },
        child: const Text('Go Back to Main Screen'),
      ),
    );
  }
}
