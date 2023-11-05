import 'package:flutter/material.dart';

class SecondSection extends StatelessWidget {
  const SecondSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "This is Second Section",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // Navigate to Screen Generator
              Navigator.of(context).pushNamed("/generator");
            },
            child: const Text('Go To Screen Generator'),
          ),
        ],
      ),
    );
  }
}
