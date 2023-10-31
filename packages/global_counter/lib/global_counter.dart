library global_counter;

import 'package:flutter/material.dart';
import 'package:global_counter/counter_widget.dart';
import 'package:scoped_model/scoped_model.dart';

class GlobalState extends Model {
  final List<CounterWidget> _counters = [CounterWidget()];

  // kembalikan list counter
  List<CounterWidget> get counters => _counters;

  void addCounter() {
    _counters.add(CounterWidget());
    notifyListeners();
    // update Model ketika tambah counter
  }

  void removeCounter(int index) {
    if (index >= 0 && index < _counters.length) {
      _counters.removeAt(index);
      notifyListeners();
      // update Model ketika hapus counter
    }
  }

  void updateColor(int index, Color newColor) {
    _counters[index].counterColor = newColor;
    notifyListeners();
    // update Model ketika warna counter berubah
    // terpaksa pakai notifyListener karena initialisasi warna counter [Card] bukan di dalam Stateful
  }
}
