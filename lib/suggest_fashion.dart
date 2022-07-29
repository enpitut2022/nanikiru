import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import '../utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nanikiru/fahion_list.dart';
import 'dart:developer' as developer;


class _MyPainterBody extends CustomPainter {

  // ※ コンストラクタに引数を持たせたい場合はこんな感じで
  _MyPainterBody(this.topscolor, this.bottomscolor, this.outercolor, this.shoescolor, this.device_width, this.device_height);
  String topscolor;
  String bottomscolor;
  String outercolor;
  String shoescolor;
  double device_width;
  double device_height;

  // 表示の調整に使う変数
  // 左側の描画のマージン
  final leftmargin = 30.0;
  // トップスのサイズ
  final topssize = 100.0;
  // ボトムスのサイズ
  final bottomssize = 100.0;
  // 各画像の幅
  final width = 130;

  // 実際の描画処理を行うメソッド
  @override
  void paint(Canvas canvas, Size size) {

    // ここに描画の処理を書く
    // outer なし版(画面左)
    final paint = Paint();

    // tops の描画
    paint.color = Color(int.parse(topscolor, radix: 16));
    canvas.drawRect(Rect.fromLTWH(0 +leftmargin,10,25,40), paint);
    canvas.drawRect(Rect.fromLTWH(75 +leftmargin,10,25,40), paint);
    canvas.drawRect(Rect.fromLTWH(20 +leftmargin,20,60,80), paint);

    // bottoms の描画
    paint.color = Color(int.parse(bottomscolor, radix: 16));
    canvas.drawRect(Rect.fromLTWH(20+leftmargin, 0 +topssize,35,36), paint);
    canvas.drawRect(Rect.fromLTWH(55+leftmargin, 0 +topssize,25,100), paint);
    canvas.drawRect(Rect.fromLTWH(20+leftmargin, 0 +topssize,25,100), paint);

    // shoes の描画
    paint.color = Color(int.parse(shoescolor, radix: 16));
    canvas.drawRect(Rect.fromLTWH(10 +leftmargin,0 +topssize +bottomssize,35,23), paint);
    canvas.drawRect(Rect.fromLTWH(55 +leftmargin,0 +topssize +bottomssize,35,23), paint);


    // outer あり版(画面右)
    // outer の裏側の描画
    paint.color = Color(int.parse(outercolor, radix: 16));
    canvas.drawRect(Rect.fromLTWH(30 +device_width -leftmargin -100, 12 ,40,150), paint);

    // tops の描画
    paint.color = Color(int.parse(topscolor, radix: 16));
    canvas.drawRect(Rect.fromLTWH(0 +device_width -leftmargin -100,10,25,40), paint);
    canvas.drawRect(Rect.fromLTWH(75 +device_width -leftmargin -100,10,25,40), paint);
    canvas.drawRect(Rect.fromLTWH(20 +device_width -leftmargin -100,20,60,80), paint);
    //paint.color = Colors.white;
    //canvas.drawRect(Rect.fromLTWH(25 +device_width -leftmargin -100,9,50,10), paint);

    // bottoms の描画
    paint.color = Color(int.parse(bottomscolor, radix: 16));
    canvas.drawRect(Rect.fromLTWH(20+device_width -leftmargin -100, 0 +topssize,35,36), paint);
    canvas.drawRect(Rect.fromLTWH(55+device_width -leftmargin -100, 0 +topssize,25,100), paint);
    canvas.drawRect(Rect.fromLTWH(20+device_width -leftmargin -100, 0 +topssize,25,100), paint);

    // shoes の描画
    paint.color = Color(int.parse(shoescolor, radix: 16));
    canvas.drawRect(Rect.fromLTWH(10 +device_width -leftmargin -100,0 +topssize +bottomssize,35,23), paint);
    canvas.drawRect(Rect.fromLTWH(55 +device_width -leftmargin -100,0 +topssize +bottomssize,35,23), paint);

    //outer の描画
    paint.color = Color(int.parse(outercolor, radix: 16));
    canvas.drawRect(Rect.fromLTWH(0 +device_width -leftmargin -100, 9 ,40,150), paint);
    canvas.drawRect(Rect.fromLTWH(60+device_width -leftmargin -100, 9, 40,150), paint);
    var pathleft = Path();
    pathleft.moveTo(0 +device_width -leftmargin -100, 9);
    pathleft.lineTo(-15 +device_width -leftmargin -100, 155);
    pathleft.lineTo(0 +device_width -leftmargin -100, 155);
    pathleft.close();
    canvas.drawPath(pathleft, paint);
    var pathright = Path();
    pathright.moveTo(100 +device_width -leftmargin -100, 9);
    pathright.lineTo(115 +device_width -leftmargin -100, 155);
    pathright.lineTo(100 +device_width -leftmargin -100, 155);
    pathright.close();
    canvas.drawPath(pathright, paint);

  }

  // 再描画のタイミングで呼ばれるメソッド
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
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
    paint.color = Color(int.parse(color, radix: 16));
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

class _MyPainterBottoms extends CustomPainter {

  // ※ コンストラクタに引数を持たせたい場合はこんな感じで
  _MyPainterBottoms(this.color);
  String color;


  // 実際の描画処理を行うメソッド
  @override
  void paint(Canvas canvas, Size size) {
    // ここに描画の処理を書く
    const margin = 25.0;
    final paint = Paint();
    paint.color = Color(int.parse(color, radix: 16));
    canvas.drawRect(Rect.fromLTWH(0+margin,0,35,36), paint);
    canvas.drawRect(Rect.fromLTWH(35+margin,0,25,100), paint);
    canvas.drawRect(Rect.fromLTWH(0+margin,0,25,100), paint);
  }

  // 再描画のタイミングで呼ばれるメソッド
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _MyPainterShoes extends CustomPainter {

  // ※ コンストラクタに引数を持たせたい場合はこんな感じで
  _MyPainterShoes(this.color);
  String color;


  // 実際の描画処理を行うメソッド
  @override
  void paint(Canvas canvas, Size size) {
    // ここに描画の処理を書く
    final paint = Paint();
    paint.color = Color(int.parse(color, radix: 16));
    canvas.drawRect(Rect.fromLTWH(10+5,0,35,23), paint);
    canvas.drawRect(Rect.fromLTWH(55+5,0,35,23), paint);
  }

  // 再描画のタイミングで呼ばれるメソッド
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class SuggestFashion extends StatefulWidget {
  SuggestFashion(this.men, {super.key, required this.storage});

  final CounterStorage2 storage;
  final bool men;

  @override
  _RegisteredClothesState createState() => _RegisteredClothesState();
}

class _RegisteredClothesState extends State<SuggestFashion> {
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

  @override
  Widget build(BuildContext context) {
    final device_width = MediaQuery.of(context).size.width;
    final device_height = MediaQuery.of(context).size.height;

      Map category;
    if(widget.men){
      category = men_category;
    }
    else{
      category = women_category;
    }

    List rand_nums = [];
    category.forEach((key, value) {
      rand_nums.add(Random().nextInt(value.length));
    });

    List category_rands = [];
    for (var key in fashion_map.keys) {
      if (fashion_map[key].length > 0) {
        category_rands.add(Random().nextInt(fashion_map[key].length));
      }
      else{
        category_rands.add(0);
      }
    }

    List colors = [];
    for (var i = 0; i <= 3; i++){
      if (fashion_map[category.keys.elementAt(i)].length == 0){
        colors.add('ff000000');
      }
      else{
        colors.add(color_map[category.keys.elementAt(i)][category_rands[i]]);
      }
    }



    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('NANIKIRU'),
      ),
      body: Column(
        children: <Widget>[
          //登録がない場合はランダムで提案
          for (var i = 0; i <= 3; i++)
            if (fashion_map[category.keys.elementAt(i)].length == 0)  ... [Text(category.keys.elementAt(i)+":"+category[category.keys.elementAt(i)][rand_nums[i]])] else Text(category.keys.elementAt(i)+":"+fashion_map[category.keys.elementAt(i)][category_rands[i]]),
          CustomPaint(
            size: Size(400,100), //child:や親ウィジェットがない場合はここでサイズを指定できる
            painter: _MyPainterBody(colors[0], colors[1], colors[2], colors[3], device_width, device_height),
          ),
          // CustomPaint(
          //   size: Size(400,100), //child:や親ウィジェットがない場合はここでサイズを指定できる
          //   painter: _MyPainterTops(colors[0]),
          // ),
          // CustomPaint(
          //   size: Size(400,100), //child:や親ウィジェットがない場合はここでサイズを指定できる
          //   painter: _MyPainterBottoms(colors[1]),
          // ),
          // CustomPaint(
          //   size: Size(400,100), //child:や親ウィジェットがない場合はここでサイズを指定できる
          //   painter: _MyPainterShoes(colors[3]),
          // ),
        ],
      ),
    );
  }


}