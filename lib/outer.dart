import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nanikiru/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'utils/constants.dart';

import 'main.dart';


class CounterStorage_outer {
  CounterStorage_outer(this.men);
  bool men;

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

  Future<File> writeCounter(String counter, String color, List<String> tag) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString("outer" + ',' + counter + ',' + color + ',' + tag.toString() + '\n' ,mode:FileMode.append);
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
  Map men_category = Constants().men_category;
  Map women_category = Constants().women_category;
  final tags = [
    "春",
    "夏",
    "秋",
    "冬"
  ];
  var selectedTags = <String>[];
  String tops_sentaku = "サンダル";
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
    if (gender){
      tops_sentaku = men_category['outer'][0];
    }else{
      tops_sentaku = women_category['outer'][0];
    }
  }

  Future<File> _incrementCounter() {

    // Write the variable as a string to the file.
    return widget.storage.writeCounter(tops_sentaku, selectedColor.value.toRadixString(16), selectedTags.toList());
  }

  List<Widget> _buildBody() {

    List<Widget> children;

    if (gender) {
      children = <Widget>[
        RadioListTile(
            title: Text(men_category['outer'][0]),
            value: men_category['outer'][0],
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(men_category['outer'][1]),
            value: men_category['outer'][1],
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(men_category['outer'][2]),
            value: men_category['outer'][2],
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(men_category['outer'][3]),
            value: men_category['outer'][3],
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(men_category['outer'][4]),
            value: men_category['outer'][4],
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        ElevatedButton(
          onPressed: (){
            _showPicker(context);
          },
          child: const Text('色選択'),
        ),
        Wrap(
          runSpacing: 16,
          spacing: 16,
          children: tags.map((tag) {
            // selectedTags の中に自分がいるかを確かめる
            final isSelected = selectedTags.contains(tag);
            return InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(32)),
              onTap: () {
                if (isSelected) {
                  // すでに選択されていれば取り除く
                  selectedTags.remove(tag);
                } else {
                  // 選択されていなければ追加する
                  selectedTags.add(tag);
                }
                setState(() {});
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  border: Border.all(
                    width: 2,
                    color: Colors.pink,
                  ),
                  color: isSelected ? Colors.pink : null,
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        Expanded(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectedTags.clear();
                    setState(() {});
                  },
                  child: const Text('クリア'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // deep copy する方法
                    // selectedTags = tags だと参照を渡したことにしかならない
                    selectedTags = List.of(tags);
                    setState(() {});
                  },
                  child: const Text('ぜんぶ'),
                ),
              ],
            ),
          ),
        ),
      ];
    } else {
      children = <Widget>[
        RadioListTile(
            title: Text(women_category['outer'][0]),
            value: women_category['outer'][0],
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(women_category['outer'][1]),
            value: women_category['outer'][1],
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(women_category['outer'][2]),
            value: women_category['outer'][2],
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(women_category['outer'][3]),
            value: women_category['outer'][3],
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        RadioListTile(
            title: Text(women_category['outer'][4]),
            value: women_category['outer'][4],
            groupValue: tops_sentaku,
            onChanged: _onRadioSelected
        ),
        ElevatedButton(
          onPressed: (){
            _showPicker(context);
          },
          child: const Text('色選択'),

        ), Wrap(
          runSpacing: 16,
          spacing: 16,
          children: tags.map((tag) {
            // selectedTags の中に自分がいるかを確かめる
            final isSelected = selectedTags.contains(tag);
            return InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(32)),
              onTap: () {
                if (isSelected) {
                  // すでに選択されていれば取り除く
                  selectedTags.remove(tag);
                } else {
                  // 選択されていなければ追加する
                  selectedTags.add(tag);
                }
                setState(() {});
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  border: Border.all(
                    width: 2,
                    color: Colors.pink,
                  ),
                  color: isSelected ? Colors.pink : null,
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        Expanded(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectedTags.clear();
                    setState(() {});
                  },
                  child: const Text('クリア'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // deep copy する方法
                    // selectedTags = tags だと参照を渡したことにしかならない
                    selectedTags = List.of(tags);
                    setState(() {});
                  },
                  child: const Text('ぜんぶ'),
                ),
              ],
            ),
          ),
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
