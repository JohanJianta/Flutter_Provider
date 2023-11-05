import 'package:counter_app/counter_screen.dart';
import 'package:counter_app/main_screen.dart';
import 'package:counter_app/generator_screen.dart';
import 'package:counter_app/new_generated_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case '/counter':
        return MaterialPageRoute(builder: (_) => const CounterScreen());
      case '/generator':
        return MaterialPageRoute(builder: (_) => GeneratorScreen());
      case '/generatedScreen':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => NewGeneratedScreen(index: args));
        } else {
          return _errorRoute();
        }
      default:
        return _errorRoute();
    }
  }

  // error handling apabila route tidak tersedia atau argument tidak sesuai
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Page Not Found")),
      );
    });
  }
}
