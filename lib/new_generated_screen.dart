import 'package:flutter/material.dart';

class NewGeneratedScreen extends StatelessWidget {
  final String index;

  const NewGeneratedScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generated Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "This is Screen-$index",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate to Screen Generator
                Navigator.of(context).pop();
              },
              child: const Text('Back To Screen Generator'),
            ),
          ],
        ),
      ),
    );
  }
}
