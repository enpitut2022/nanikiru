import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'main.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: FlutterDemo_outer(storage: CounterStorage_outer()),
    ),
  );
}

class CounterStorage_outer {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter3.txt');
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<File> writeCounter(String counter, String color) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString("outer" + ',' + counter + ',' + color + '\n' ,mode:FileMode.append);
  }
}

class FlutterDemo_outer extends StatefulWidget {
  const FlutterDemo_outer({super.key, required this.storage});

  final CounterStorage_outer storage;

  @override
  State<FlutterDemo_outer> createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo_outer> {
  String _counter = "";
  List<String> tops = [
    "コート",
    "ジャケット",
    "ブルゾン",
    "スーツ",
    "その他アウター"
  ];

  int tops_sentaku = 0;
  Color selectedColor = Colors.blue;
  Color pickerColor = Colors.blue;

  void _changeColor(Color color) {
    pickerColor = color;
  }

  void _showPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: _changeColor,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() => selectedColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _incrementCounter() {

    // Write the variable as a string to the file.
    return widget.storage.writeCounter(tops[tops_sentaku], selectedColor.value.toRadixString(16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NANIKIRU'),
        backgroundColor: Color(0xff81d4fa),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RadioListTile(
              title: Text(tops[0]),
              value: 0,
              groupValue: tops_sentaku,
              onChanged: _onRadioSelected
          ),
          RadioListTile(
              title: Text(tops[1]),
              value: 1,
              groupValue: tops_sentaku,
              onChanged: _onRadioSelected
          ),
          RadioListTile(
              title: Text(tops[2]),
              value: 2,
              groupValue: tops_sentaku,
              onChanged: _onRadioSelected
          ),
          RadioListTile(
              title: Text(tops[3]),
              value: 3,
              groupValue: tops_sentaku,
              onChanged: _onRadioSelected
          ),
          RadioListTile(
              title: Text(tops[4]),
              value: 4,
              groupValue: tops_sentaku,
              onChanged: _onRadioSelected
          ),
          ElevatedButton(
            onPressed: (){
              _showPicker(context);
            },
            child: const Text('色選択'),

          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),

    );
  }
  _onRadioSelected(value) =>
      setState(() {
        tops_sentaku = value;
      });
}
