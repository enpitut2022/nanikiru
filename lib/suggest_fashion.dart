import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import '../utils/constants.dart';

class _MyPainterTops extends CustomPainter {

  // ※ コンストラクタに引数を持たせたい場合はこんな感じで
  //double value;
  //_MyPainter(this.value);

  // 実際の描画処理を行うメソッド
  @override
  void paint(Canvas canvas, Size size) {
    // ここに描画の処理を書く
    final paint = Paint();
    paint.color = Colors.red;
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
  //double value;
  //_MyPainter(this.value);

  // 実際の描画処理を行うメソッド
  @override
  void paint(Canvas canvas, Size size) {
    // ここに描画の処理を書く
    final paint = Paint();
    paint.color = Colors.blue;
    canvas.drawRect(Rect.fromLTWH(0,0,15,60), paint);
    canvas.drawRect(Rect.fromLTWH(20,0,30,60), paint);
    canvas.drawRect(Rect.fromLTWH(0,0,30,25), paint);
  }

  // 再描画のタイミングで呼ばれるメソッド
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


class SuggestFashion extends StatelessWidget{

  SuggestFashion(this.men);
  bool men;
  Map men_category = Constants().men_category;
  Map women_category = Constants().women_category;

  @override
  Widget build(BuildContext context) {
    Map category;
    if(men){
      category = men_category;
    }
    else{
      category = women_category;
    }

    List rand_nums = [];
    category.forEach((key, value) {
      rand_nums.add(Random().nextInt(value.length));
    });

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('NANIKIRU'),
      ),
      body: Column(
        children: <Widget>[
          for (var i = 0; i <= 3; i++)
            Text(category.keys.elementAt(i)+":"+category[category.keys.elementAt(i)][rand_nums[i]]),
          CustomPaint(
            size: Size(400,100), //child:や親ウィジェットがない場合はここでサイズを指定できる
            painter: _MyPainterTops(),
          ),
          CustomPaint(
            size: Size(400,100), //child:や親ウィジェットがない場合はここでサイズを指定できる
            painter: _MyPainterBottoms(),
          ),

        ],
      ),
    );
  }


}