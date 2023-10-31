// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:global_counter/global_counter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:math' as math;

Color generatePastelColor() {
  final random = math.Random();

  // Generate warna pastel dengan melimitasi nilai RGB
  final red = (random.nextInt(156) + 100); // nilai Red [100 ~ 255]
  final green = (random.nextInt(156) + 100); // nilai Green [100 ~ 255]
  final blue = (random.nextInt(156) + 100); // nilai Blue [100 ~ 255]

  return Color.fromARGB(255, red, green, blue);
}

class CounterWidget extends StatefulWidget {
  CounterWidget({super.key});

  String label = 'New Counter';
  Color counterColor = generatePastelColor();

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _value = 0;

  void increment() {
    // setState agar tampilan ikut terupdate ketika value bertambah
    setState(() {
      _value++;
    });
  }

  void decrement() {
    if (_value > 0) {
      // setState agar tampilan ikut terupdate ketika value berkurang
      setState(() {
        _value--;
      });
    }
  }

  void updateLabel(String newLabel) {
    setState(() {
      // setState agar tampilan ikut terupdate ketika label berubah
      widget.label = newLabel;
    });
  }

  // kembalikan index counter dari GlobalState
  int getIndex(BuildContext context) {
    return ScopedModel.of<GlobalState>(context).counters.indexOf(widget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // Stack agar bisa pakai Positioned
      children: [
        // posisikan tombol more di pojok kanan atas
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Tampilkan list aksi (pass fungsi updateLabel)
              showActions(context, getIndex(context), updateLabel);
            },
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                '$_value',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: increment,
                child: const Text('Increment'),
              ),
              ElevatedButton(
                onPressed: decrement,
                child: const Text('Decrement'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void showActions(BuildContext context, int counterIndex,
    Function(String) updateLabelCallback) {
  // Tampilkan list aksi dengan PopupMenuButton
  final RenderBox button = context.findRenderObject() as RenderBox;
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  showMenu(
    context: context,
    position: RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    ),
    items: <PopupMenuEntry>[
      PopupMenuItem(
        child: const Text('Change Label'),
        onTap: () {
          // edit label counter
          showChangeLabelDialog(context, counterIndex, updateLabelCallback);
        },
      ),
      PopupMenuItem(
        child: const Text('Change Color'),
        onTap: () {
          // edit warna counter
          showColorPickerDialog(context, counterIndex);
        },
      ),
      PopupMenuItem(
        child: const Text('Remove'),
        onTap: () {
          // hapus counter dari GlobalState
          ScopedModel.of<GlobalState>(context).removeCounter(counterIndex);
        },
      ),
    ],
  );
}

Future<void> showChangeLabelDialog(BuildContext context, int counterIndex,
    Function(String) onLabelUpdated) async {
  // ambil label counter saat ini lewat GlobalState
  String currentLabel =
      ScopedModel.of<GlobalState>(context).counters[counterIndex].label;
  String newLabel = currentLabel;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Change Label'),
        content: TextField(
          onChanged: (value) {
            newLabel = value;
          },
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              // cek apakah label berubah
              if (newLabel != currentLabel && newLabel.isNotEmpty) {
                onLabelUpdated(newLabel);
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showColorPickerDialog(
    BuildContext context, int counterIndex) async {
  // ambil warna counter saat ini lewat GlobalState
  Color currentColor =
      ScopedModel.of<GlobalState>(context).counters[counterIndex].counterColor;
  Color newColor = currentColor;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Change Color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color newPickedColor) {
                newColor = newPickedColor;
              },
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              // cek apakah color berubah
              if (newColor != currentColor) {
                ScopedModel.of<GlobalState>(context)
                    .updateColor(counterIndex, newColor);
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
