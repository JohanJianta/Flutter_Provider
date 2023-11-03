import 'package:counter_app/second_screen.dart';
import 'package:counter_app/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:global_counter/global_counter.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:scoped_model/scoped_model.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _currentIndex = 0;
  Widget screen = const CounterList();

  final List<Widget> screens = [
    const CounterList(),
    const SecondScreen(),
    const ThirdScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Session 5 Assignments - Navigation')),
      body: screen,
      floatingActionButton: const AddCounterButton(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "First"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Second"),
          BottomNavigationBarItem(icon: Icon(Icons.delete), label: "Third"),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            screen = screens[index];
          });

          // final List<String> routes = ['/', '/second', '/third'];
          // Navigator.of(context).pushNamed(routes[index]);
        },
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
            return ReorderableItemView(
              // tambah key & index agar sistem bisa bedakan tiap Card
              key: ValueKey(counter),
              index: model.counters.indexOf(counter),
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
