// import 'package:flutter/material.dart';
import 'package:counter_app/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:global_counter/global_counter.dart';
import 'package:scoped_model/scoped_model.dart';

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
      child: const MaterialApp(
        // set MainScreen sebagai tampilan awal
        initialRoute: '/',
        // set list Route navigasi
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
