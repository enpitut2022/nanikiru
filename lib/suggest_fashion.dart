import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import '../utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nanikiru/fahion_list.dart';
import 'dart:developer' as developer;


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

class Closet {
  Map fashion_map = {'tops':[''], 'bottoms':[''], 'outer':[''], 'shoes':['']};
  Map color_map = {'tops':[''], 'bottoms':[''], 'outer':[''], 'shoes':['']};
  List rand_nums = [0, 0, 0, 0];
  List category_rands = [0, 0, 0, 0];
  List colors = ['ff000000', 'ff000000', 'ff000000', 'ff000000'];

  void registerClothes(value){
    List fashion_list = value.split('\n');
    fashion_list.removeLast();
    List item_information;

    for (var i = 0; i < fashion_list.length; i++) {
      item_information = fashion_list[i].split(',');
      fashion_map[item_information[0]].add(item_information[1]);
      color_map[item_information[0]].add(item_information[2]);
    }
    for (var key in fashion_map.keys) {
      fashion_map[key].removeAt(0);
      color_map[key].removeAt(0);
    }
  }

  void randomSuggestion(category){
    for (var i = 0; i <= 3; i++) {
      if (fashion_map[category.keys.elementAt(i)].length != 0) {
        category_rands[i] = Random().nextInt(fashion_map.values.elementAt(i).length);
        colors[i] = color_map[category.keys.elementAt(i)][category_rands[i]];
      }
      else{
        rand_nums[i] = Random().nextInt(category.values.elementAt(i).length);
      }
    }
  }

}

class _RegisteredClothesState extends State<SuggestFashion> {
  Closet closet = Closet();

  Map men_category = Constants().men_category;
  Map women_category = Constants().women_category;
  Map category = {};

  final tags = [
    "春",
    "夏",
    "秋",
    "冬"
  ];
  var selectedTags = <String>[];

  @override
  void initState() {
    super.initState();
    if(widget.men){
      category = men_category;
    }
    else{
      category = women_category;
    }

    widget.storage.readCounter().then((value) {
      setState(() {
        closet.registerClothes(value);
        closet.randomSuggestion(category);
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('NANIKIRU'),
      ),
      body: Column(
        children: <Widget>[
          //登録がない場合はランダムで提案
          for (var i = 0; i <= 3; i++)
            if (closet.fashion_map[category.keys.elementAt(i)].length == 0)  ... [Text(category.keys.elementAt(i)+":"+category[category.keys.elementAt(i)][closet.rand_nums[i]])] else Text(category.keys.elementAt(i)+":"+closet.fashion_map[category.keys.elementAt(i)][closet.category_rands[i]]),
          CustomPaint(
            size: Size(400,100), //child:や親ウィジェットがない場合はここでサイズを指定できる
            painter: _MyPainterTops(closet.colors[0]),
          ),
          CustomPaint(
            size: Size(400,100), //child:や親ウィジェットがない場合はここでサイズを指定できる
            painter: _MyPainterBottoms(closet.colors[1]),
          ),
          CustomPaint(
            size: Size(400,100), //child:や親ウィジェットがない場合はここでサイズを指定できる
            painter: _MyPainterShoes(closet.colors[3]),
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

                  ElevatedButton(
                    onPressed: () {
                    },
                    child: Text(
                      "絞り込む",
                      style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink, //ボタンの背景色
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}