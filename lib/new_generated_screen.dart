import 'package:flutter/material.dart';

class NewGeneratedScreen extends StatelessWidget {
  const NewGeneratedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // terima argument indeks dari halaman sebelumnya
    final String index = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Generated Screen $index'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "This is Screen $index",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            TextButton(
              // Navigate to Screen Generator
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back To Screen Generator'),
            ),
          ],
        ),
      ),
    );
  }
}
