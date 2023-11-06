import 'package:counter_app/counter_screen.dart';
import 'package:counter_app/main_screen.dart';
import 'package:counter_app/generator_screen.dart';
import 'package:counter_app/new_generated_screen.dart';
import 'package:flutter/material.dart';
import 'package:global_counter/global_counter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:animations/animations.dart';

void main() => runApp(MyCounterApp());

class MyCounterApp extends StatelessWidget {
  MyCounterApp({super.key});

  // buat instance GlobalState
  final GlobalState globalStateModel = GlobalState();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<GlobalState>(
      // tambah model agar bisa dipakai oleh child & descendants
      model: globalStateModel,
      child: MaterialApp(
        theme: ThemeData(
          // set animasi default untuk transisi antar-screen
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.horizontal,
              ),
              TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.horizontal,
              ),
              TargetPlatform.windows: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.horizontal,
              ),
              TargetPlatform.linux: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.horizontal,
              ),
            },
          ),
        ),
        // set MainScreen sebagai tampilan awal
        initialRoute: '/',
        // set list Route navigasi
        routes: {
          '/': (context) => const MainScreen(),
          '/counter': (context) => const CounterScreen(),
          '/generator': (context) => const GeneratorScreen(),
          '/generatedScreen': (context) => const NewGeneratedScreen(),
        },
      ),
    );
  }
}
