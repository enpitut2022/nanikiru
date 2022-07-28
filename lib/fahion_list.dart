import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: FlutterDemo_2(storage: CounterStorage2()),
    ),
  );
}

class CounterStorage2 {
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

  Future<File> writeCounter(String counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString("a" ,mode:FileMode.append);
  }
}

class FlutterDemo_2 extends StatefulWidget {
  const FlutterDemo_2({super.key, required this.storage});

  final CounterStorage2 storage;

  @override
  State<FlutterDemo_2> createState() => _FlutterDemoState();
}


class _FlutterDemoState extends State<FlutterDemo_2> {
  String _counter = "";


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
    setState(() {
      widget.storage.readCounter().then((value) {
        setState(() {
          _counter = value;
        });
      });
    });

    // Write the variable as a string to the file.
    return widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff81d4fa),
        title: const Text('Reading and Writing Files'),
      ),
      body: Center(
        child: Text(
            _counter
        ),
      ),
    );
  }
}