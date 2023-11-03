// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:global_counter/global_counter.dart';
import 'package:scoped_model/scoped_model.dart';

import 'first_screen.dart';
import 'second_screen.dart';
import 'third_screen.dart';

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
        // set FirstScreen sebagai tampilan awal
        initialRoute: '/',
        // list Route navigasi
        routes: {
          // Route "/" akan menampilkan FirstScreen widget.
          '/': (context) => const FirstScreen(),
          // Route "/second" akan menampilkan SecondScreen widget.
          '/second': (context) => const SecondScreen(),
          // Route "/third" akan menampilkan ThirdScreen widget.
          '/third': (context) => const ThirdScreen(),
        },
      ),
    );
  }
}
