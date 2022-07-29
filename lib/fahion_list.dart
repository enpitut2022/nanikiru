import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'main.dart';
import 'utils/constants.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: FlutterDemo_2(storage: CounterStorage2()),
    ),
  );
}

class _MyPainterTops extends CustomPainter {

  // ※ コンストラクタに引数を持たせたい場合はこんな感じで
  _MyPainterTops(this.color);
  String color;

  // 実際の描画処理を行うメソッド
  @override
  void paint(Canvas canvas, Size size) {
    // ここに描画の処理を書く
    final paint = Paint();
    paint.color = Color(int.parse(color));
    const margin = 5.0;
    canvas.drawRect(Rect.fromLTWH(0 +margin,10,100,40), paint);
    canvas.drawRect(Rect.fromLTWH(20 +margin,30,60,70), paint);
    paint.color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(25 +margin,9,50,10), paint);
  }

  // 再描画のタイミングで呼ばれるメソッド
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
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
  List fashion_list = [''];

  Map fashion_map = {'tops':[''], 'bottoms':[''], 'outer':[''], 'shoes':[''], 'dress':['']};
  Map color_map = {'tops':[''], 'bottoms':[''], 'outer':[''], 'shoes':[''], 'dress':['']};

  Map men_category = Constants().men_category;
  Map women_category = Constants().women_category;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) {
      setState(() {
        fashion_list = value.split('\n');
        fashion_list.removeLast();

        for (var i = 0; i < fashion_list.length; i++) {
          List item_information;
          item_information = fashion_list[i].split(',');
          fashion_map[item_information[0]].add(item_information[1]);
          color_map[item_information[0]].add(item_information[2]);

        }
        // fashion_map.forEach((String key, List value){
        for (var key in fashion_map.keys) {
          fashion_map[key].removeAt(0);
          color_map[key].removeAt(0);
        };

        // });
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
    var list_fashion = fashion_map['tops'];
    var color_fashion = color_map['tops'];
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('ListView'),
            ),
            body: ListView.builder(
              itemCount: list_fashion.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Color(int.parse("0xff" + color_fashion[index])),
                  child: _messageItem(list_fashion[index], "0xff" + color_fashion[index]),
                );
              },
            )
        )
    );
  }

  Widget _messageItem(String title, String col) {
    return Container(
      decoration: new BoxDecoration(
          border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      child:ListTile(
        title: Text(
          title,
          style: TextStyle(
              color:Colors.black,
              fontSize: 18.0
          ),
        ),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return Column(
                  children: <Widget>[
                    AlertDialog(
                      title: Text(title),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            CustomPaint(
                              size: Size(400,100), //child:や親ウィジェットがない場合はここでサイズを指定できる
                              painter: _MyPainterTops(col),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        // ボタン
                      ],
                    ),
                  ],
                );
              }
          );
        }, // タップ
        onLongPress: () {
          print("onLongTap called.");
        }, // 長押し
      ),
    );
  }
}