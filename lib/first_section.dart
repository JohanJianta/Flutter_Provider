import 'package:flutter/material.dart';

class FirstSection extends StatelessWidget {
  const FirstSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "This is First Section",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // Navigate to Counter List
              Navigator.of(context).pushNamed("/counter");
            },
            child: const Text('Go To Counter List'),
          ),
        ],
      ),
    );
  }
}
