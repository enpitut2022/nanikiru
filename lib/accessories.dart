import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'main.dart';



class CounterStorageaccessories {
  CounterStorageaccessories(this.men);
  bool men;
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/accessories.txt');
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
    return file.writeAsString("accessories" + ',' + counter + ',' + color + '\n' ,mode:FileMode.append);
  }
}

class FlutterDemo_accessories extends StatefulWidget {
  const FlutterDemo_accessories({super.key, required this.storage});

  final CounterStorageaccessories storage;

  @override
  State<FlutterDemo_accessories> createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo_accessories> {
  String _counter = "";
  List<String> accessories = [
  "ハット・帽子",
  "ピアス・指輪",
  "ネックレス",
  "ブレスレット",
  "ベルト",
  "ストール・マフラー",
  "靴下",
  "時計",
  "その他アクセサリー",

  "ヘアアクセ",
  "ハット・帽子",
  "ピアス・指輪",
  "ネックレス",
  "ブレスレット",
  "ベルト",
  "ストール・マフラー",
  "タイツ・靴下",
  "時計",
  "その他アクセサリー"
  ];

  int accessories_sentaku = 0;
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
    return widget.storage.writeCounter(accessories[accessories_sentaku], selectedColor.value.toRadixString(16));
  }
  List<Widget> _buildBody() {

    List<Widget> children;

    if (gender) {
      children = <Widget>[
        RadioListTile(
            title: Text(accessories[0]),
            value: 0,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[1]),
            value: 1,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[2]),
            value: 2,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[3]),
            value: 3,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[4]),
            value: 4,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[5]),
            value: 5,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[6]),
            value: 6,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[7]),
            value: 7,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[8]),
            value: 8,
            groupValue: accessories_sentaku,
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
            title: Text(accessories[9]),
            value: 9,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[10]),
            value: 10,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[11]),
            value: 11,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[12]),
            value: 12,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[13]),
            value: 13,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[14]),
            value: 14,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[15]),
            value: 15,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[16]),
            value: 16,
            groupValue: accessories_sentaku,
            onChanged: _onRadioSelected
        ),RadioListTile(
            title: Text(accessories[17]),
            value: 17,
            groupValue: accessories_sentaku,
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
      appBar: AppBar(
        title: const Text('NANIKIRU'),
        backgroundColor: Color(0xff81d4fa),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildBody()
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
        accessories_sentaku = value;
      });

}
