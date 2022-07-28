import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'main.dart';


class CounterStorageshoose {
  CounterStorageshoose(this.men);
  bool men;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/shoose.txt');
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
    return file.writeAsString("shoose" + ',' + counter + ',' + color + '\n' ,mode:FileMode.append);
  }
}

class FlutterDemo_shoose extends StatefulWidget {
  const FlutterDemo_shoose({super.key, required this.storage});

  final CounterStorageshoose storage;

  @override
  State<FlutterDemo_shoose> createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo_shoose> {
  String _counter = "";
  List<String> tops = [
  "サンダル",
  "スニーカー",
  "ドレスシューズ",
  "その他シューズ",

    "パンプス",
    "サンダル",
    "ブーティ",
    "ショートブーツ",
    "ロングブーツ",
    "ニーハイブーツ",
    "スニーカー",
    "ドレスシューズ",
    "その他シューズ"
  ];

  int tops_sentaku = 0;
  Color selectedColor = Colors.blue;
  Color pickerColor = Colors.blue;
  bool gender = false;

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
    gender = widget.storage.men;
  }

  Future<File> _incrementCounter() {

    // Write the variable as a string to the file.
    return widget.storage.writeCounter(tops[tops_sentaku], selectedColor.value.toRadixString(16));
  }

  List<Widget> _buildBody() {

    List<Widget> children;

    if (gender) {
      children = <Widget>[
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
        ElevatedButton(
          onPressed: (){
            _showPicker(context);
          },
          child: const Text('色選択'),

        ),
      ];
    } else {
      children = <Widget>[
        RadioListTile(
            title: Text(tops[4]),
            value: 4,
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(tops[5]),
            value: 5,
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(tops[6]),
            value: 6,
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(tops[7]),
            value: 7,
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(tops[8]),
            value: 8,
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(tops[9]),
            value: 9,
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(tops[10]),
            value: 10,
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(tops[11]),
            value: 11,
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(tops[12]),
            value: 12,
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        ElevatedButton(
          onPressed: (){
            _showPicker(context);
          },
          child: const Text('色選択'),

        ),
      ];
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildBody(),
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
