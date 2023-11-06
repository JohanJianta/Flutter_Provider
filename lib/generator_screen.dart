// ignore_for_file: must_be_immutable

import 'package:counter_app/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneratorScreen extends StatefulWidget {
  const GeneratorScreen({super.key});

  @override
  State<GeneratorScreen> createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends State<GeneratorScreen> {
  final _textFieldController = TextEditingController();

  int _screenCount = 0;

  // perbarui itemCount dari ScreenList
  void updateScreenCount(int newScreenCount) {
    setState(() {
      _screenCount = newScreenCount;
      // reset TextField
      _textFieldController.text = '';
      // tutup keyboard
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Generator'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      // set controller biar TextField bisa dipanggil oleh widget lain
                      controller: _textFieldController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter the number of screens',
                      ),
                      // set cuma angka yang bisa diinput
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  // taruh button dalam SizedBox agar bisa atur height
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      // generate screen berdasarkan value dari TextField
                      onPressed: () {
                        if (_textFieldController.text.isNotEmpty) {
                          final newScreenCount =
                              int.parse(_textFieldController.text);

                          if (newScreenCount > 20) {
                            showErrorSnackBar(context,
                                "Maximum limit of generated screens is 20");
                          } else {
                            updateScreenCount(newScreenCount);
                          }
                        }
                      },
                      child: const Text('Generate'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                // tempatkan children berseberangan
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Screen List",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () => updateScreenCount(0),
                      child: const Text('Reset list')),
                ],
              ),
              // sisa space ditempati ScreenList
              Expanded(
                child: ScreenList(itemCount: _screenCount),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScreenList extends StatelessWidget {
  const ScreenList({Key? key, required this.itemCount}) : super(key: key);

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return itemCount > 0
        ? ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  try {
                    // buka halaman baru dan pass indeks sebagai argument
                    Navigator.of(context).pushNamed('/generatedScreen',
                        arguments: (index + 1).toString());
                  } catch (e) {
                    showErrorSnackBar(
                        context, "Screen not found, please try another screen");
                  }
                },
                child: ListTile(
                  title: Text("Screen ${index + 1}"),
                ),
              );
            },
          )
        // tampilkan teks apabila list kosong
        : const Center(
            child: Text("This list is empty", style: TextStyle(fontSize: 16)));
  }
}
