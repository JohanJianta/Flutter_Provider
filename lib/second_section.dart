import 'package:counter_app/error_snackbar.dart';
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
          const Text(
              "Here you can navigate to Screen Generator from Assignment 5"),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              try {
                // Navigate to Screen Generator
                Navigator.of(context).pushNamed("/generator");
              } catch (e) {
                showErrorSnackBar(context,
                    "An error occured during navigation, please try again later");
              }
            },
            child: const Text('Go To Screen Generator'),
          ),
        ],
      ),
    );
  }
}
