import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'main.dart';
import 'utils/constants.dart';

class _MyPainterTops extends CustomPainter {

  // ※ コンストラクタに引数を持たせたい場合はこんな感じで
  _MyPainterTops(this.color, this.category);
  String color;
  String category;

  // 実際の描画処理を行うメソッド
  @override
  void paint(Canvas canvas, Size size) {
    print(category);
    // ここに描画の処理を書く
    if(category == 'tops') {
      final paint = Paint();
      paint.color = Color(int.parse(color));
      const margin = 5.0;
      canvas.drawRect(Rect.fromLTWH(0 + margin, 10, 100, 40), paint);
      canvas.drawRect(Rect.fromLTWH(20 + margin, 30, 60, 70), paint);
      paint.color = Colors.white;
      canvas.drawRect(Rect.fromLTWH(25 + margin, 9, 50, 10), paint);
    }else if(category == 'bottoms'){
      const margin = 25.0;
      final paint = Paint();
      paint.color = Color(int.parse(color));
      canvas.drawRect(Rect.fromLTWH(0+margin,0,35,36), paint);
      canvas.drawRect(Rect.fromLTWH(35+margin,0,25,100), paint);
      canvas.drawRect(Rect.fromLTWH(0+margin,0,25,100), paint);
    }else if(category == 'shoes'){
      final paint = Paint();
      paint.color = Color(int.parse(color));
      canvas.drawRect(Rect.fromLTWH(10+5,0,35,23), paint);
      canvas.drawRect(Rect.fromLTWH(55+5,0,35,23), paint);
    }
  }

  // 再描画のタイミングで呼ばれるメソッド
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CounterStorage_list {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter5.txt');
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

  Future<File> writeCounter(List<String> fas_list) async {
    final file = await _localFile;
    // Write the file
    String txt_file = "";
    for (var i = 0; i < fas_list.length; i++){
      txt_file.replaceAll('[', '');
      txt_file.replaceAll(']', '');
      List fas_line = fas_list[i].split(',');

      String tags = "";
      for (var i = 3; i < fas_line.length; i++){
        if (i == fas_line.length-1){
          tags = tags + fas_line[i] + "]";
        }else if (i == 3){
          tags = "[" + tags + fas_line[i] + ',';
        }else{
          tags = tags + fas_line[i] + ',';
        }

      }
      txt_file = txt_file + fas_line[0] + ',' + fas_line[1] + ',' + fas_line[2] + ',' + tags + '\n';
    }

    return file.writeAsString(txt_file ,mode:FileMode.write);
  }
}

class FlutterDemo_list extends StatefulWidget {
  const FlutterDemo_list(this._category, {super.key, required this.storage});

  final CounterStorage_list storage;
  final String _category;

  @override
  State<FlutterDemo_list> createState() => _FlutterDemoState();
}


class _FlutterDemoState extends State<FlutterDemo_list> {
  String _counter = "";
  List<String> fashion_list = [''];

  Map fashion_map = {'tops':[''], 'bottoms':[''], 'outer':[''], 'shoes':[''], 'dress':['']};
  Map color_map = {'tops':[''], 'bottoms':[''], 'outer':[''], 'shoes':[''], 'dress':['']};
  Map index_map = {'tops':<int?>[-1], 'bottoms':<int?>[-1], 'outer':<int?>[-1], 'shoes':<int?>[-1], 'dress':<int?>[-1]};

  Map men_category = Constants().men_category;
  Map women_category = Constants().women_category;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) {
      setState(() {
        fashion_list = value.split('\n');
        fashion_list.removeLast();
        print(fashion_map);
        print(index_map);

        for (var i = 0; i < fashion_list.length; i++) {
          List item_information;
          item_information = fashion_list[i].split(',');
          fashion_map[item_information[0]].add(item_information[1]);
          color_map[item_information[0]].add(item_information[2]);
          index_map[item_information[0]].add(i);

        }
        print(fashion_map);
        print(index_map);
        print(fashion_list);
        print(value);
        // fashion_map.forEach((String key, List value){
        for (var key in fashion_map.keys) {
          fashion_map[key].removeAt(0);
          color_map[key].removeAt(0);
          index_map[key].removeAt(0);
        };

        // });
      });
    });
  }

  Future<File> _incrementCounter(List<String> fas_list, int index_fashion) {
    // Write the variable as a string to the file.
    setState(() {
      fashion_list.removeAt(index_fashion);
    });
    print(widget.storage.readCounter());
    print(fas_list);
    return widget.storage.writeCounter(fas_list);
  }

  @override
  Widget build(BuildContext context) {
    var list_fashion = fashion_map[widget._category];
    var color_fashion = color_map[widget._category];
    var index_fashion = index_map[widget._category];
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
                  child: _messageItem(list_fashion[index], "0xff" + color_fashion[index], index, index_fashion[index]),
                );
              },
            )
        )
    );
  }

  Widget _messageItem(String title, String col, int index, int index_fashion) {
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
                              painter: _MyPainterTops(col, widget._category),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text("削除"),
                          onPressed: () {
                            print(index);
                            print(index_fashion);
                            _incrementCounter(fashion_list, index_fashion);
                            fashion_map[widget._category].removeAt(index);
                            color_map[widget._category].removeAt(index);
                            index_map[widget._category].removeAt(index);
                            Navigator.of(context).pop();
                          }
                        ), // ボタン
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