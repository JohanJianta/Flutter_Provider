import 'package:counter_app/error_snackbar.dart';
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
          const Text("Here you can navigate to Counter List from Assignment 4"),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              try {
                // Navigate to Counter List
                Navigator.of(context).pushNamed("/counter");
              } catch (e) {
                showErrorSnackBar(context,
                    "An error occured during navigation, please try again later");
              }
            },
            child: const Text('Go To Counter List'),
          ),
        ],
      ),
    );
  }
}
