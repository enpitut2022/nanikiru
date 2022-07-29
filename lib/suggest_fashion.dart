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
  Map fashion_display = {'tops':[], 'bottoms':[], 'outer':[], 'shoes':[]};
  Map color_map = {'tops':[''], 'bottoms':[''], 'outer':[''], 'shoes':['']};
  Map color_display = {'tops':[], 'bottoms':[], 'outer':[], 'shoes':[]};
  Map season_map = {'tops':[], 'bottoms':[], 'outer':[], 'shoes':[]};
  Map season_match = {'tops':[], 'bottoms':[], 'outer':[], 'shoes':[]};
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
      List tags = item_information.sublist(3);
      for (var i = 0; i < tags.length; i++){
        tags[i] = tags[i].replaceAll('[', '');
        tags[i] = tags[i].replaceAll(']', '');
        tags[i] = tags[i].replaceAll(' ', '');
      }
      season_map[item_information[0]].add(tags);
      season_match[item_information[0]].add(true);
    }
    for (var key in fashion_map.keys) {
      fashion_map[key].removeAt(0);
      color_map[key].removeAt(0);
    }
  }
  void seasonSelected(season){
    fashion_display = {'tops':[], 'bottoms':[], 'outer':[], 'shoes':[]};
    color_display = {'tops':[], 'bottoms':[], 'outer':[], 'shoes':[]};
    for (var s in season){
      for (var key in season_match.keys){
        int i = 0;
        for (var cloth_season in season_map[key]){
          bool display = cloth_season.contains(s);
          if (display){
            fashion_display[key].add(fashion_map[key][i]);
            color_display[key].add(color_map[key][i]);
          }
          i += 1;
        }
      }
    }
  }

  void randomSuggestion(category){
    for (var i = 0; i <= 3; i++) {
      if (fashion_display[category.keys.elementAt(i)].length != 0) {
        category_rands[i] = Random().nextInt(fashion_display.values.elementAt(i).length);
        colors[i] = color_display[category.keys.elementAt(i)][category_rands[i]];
      }
      else{
        rand_nums[i] = Random().nextInt(category.values.elementAt(i).length);
        colors[i] = 'ff000000';
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
        closet.seasonSelected(['春', '夏', '秋', '冬']);
        closet.randomSuggestion(category);
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    List<TableRow> table_widget = [];
    final List fashion_type = ['トップス', 'ボトムス', 'アウター', 'シューズ'];
    for (var i = 0; i <= 3; i++) {
      List<Widget> row_widget = [];
      row_widget.add(Text(fashion_type[i]));
      if (closet.fashion_display[category.keys.elementAt(i)].length == 0) {
        row_widget.add(Text(category[category.keys.elementAt(i)][closet.rand_nums[i]]));
      }
      else{
        row_widget.add(Text(closet.fashion_display[category.keys.elementAt(i)][closet.category_rands[i]]));
      }
      table_widget.add(TableRow(children: row_widget));
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('NANIKIRU'),
      ),
      body: Column(
        children: <Widget>[
          //登録がない場合はランダムで提案
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
                    setState(() {
                      closet.seasonSelected(selectedTags);
                      closet.randomSuggestion(category);
                    });
                  } else {
                  // 選択されていなければ追加する
                    selectedTags.add(tag);
                    setState(() {
                      closet.seasonSelected(selectedTags);
                      closet.randomSuggestion(category);
                    });
                }
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
          Table(
            children: table_widget
          ),
          OutlinedButton(
            onPressed: (){setState(() {closet.randomSuggestion(category);});},
            child: Text('もう一度提案'),
          ),
        ],
      ),
    );
  }


}