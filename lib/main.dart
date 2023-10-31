import 'package:flutter/material.dart';
import 'package:global_counter/global_counter.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyCounterApp());

class MyCounterApp extends StatelessWidget {
  MyCounterApp({super.key});

  // buat instance GlobalState
  final GlobalState globalStateModel = GlobalState();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<GlobalState>(
      // set model agar bisa dipakai oleh child & descendants
      model: globalStateModel,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Global State Example')),
          body: const CounterList(),
          floatingActionButton: const AddCounterButton(),
        ),
      ),
    );
  }
}

class CounterList extends StatelessWidget {
  const CounterList({super.key});

  @override
  Widget build(BuildContext context) {
    // ScopedModelDescendant agar list counter terupdate ketika counter bertambah atau berkurang
    return ScopedModelDescendant<GlobalState>(
      builder: (context, child, model) {
        return ReorderableGridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
          // map seluruh counter dalam bentuk list card
          children: model.counters.map((counter) {
            return Card(
              clipBehavior: Clip.antiAlias,
              // tambah key agar sistem bisa bedakan tiap Card
              key: ValueKey(counter),
              color: counter.counterColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: counter,
            );
          }).toList(),
          onReorder: (int oldIndex, int newIndex) {
            // reorder list Card ketika Card ditekan [Notes: TEKAN LAMAAAA!!!]
            model.reorderCounter(oldIndex, newIndex);
          },
        );
      },
    );
  }
}

class AddCounterButton extends StatelessWidget {
  const AddCounterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // tambah counter ketika ditekan
        ScopedModel.of<GlobalState>(context).addCounter();
      },
      backgroundColor: Colors.blue,
      child: const Icon(Icons.add),
    );
  }
}
