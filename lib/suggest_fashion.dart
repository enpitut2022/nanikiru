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
  final leftmargin = 50.0;
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

    // 外枠のためのPaintを作る
    Paint outlinePaint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    // Pathを作る
    var path = Path();

    // tops の描画
    paint.color = Color(int.parse(topscolor, radix: 16));
    canvas.drawRect(Rect.fromLTWH(0 +leftmargin,10,25,40), paint);
    canvas.drawRect(Rect.fromLTWH(75 +leftmargin,10,25,40), paint);
    canvas.drawRect(Rect.fromLTWH(20 +leftmargin,20,60,80), paint);

    // tops の線
    paint.color = Colors.black;
    canvas.drawLine(Offset(0 +leftmargin,10), Offset(0 +leftmargin +25,10), paint); //左袖枠
    canvas.drawLine(Offset(0 +leftmargin,10+ 40), Offset(0 +leftmargin +20,10 +40), paint);
    canvas.drawLine(Offset(0 +leftmargin,10), Offset(0 +leftmargin,10 +40), paint);
    canvas.drawLine(Offset(0 +leftmargin +25,10), Offset(0 +leftmargin +25,10 +10), paint);
    canvas.drawLine(Offset(0 +leftmargin +75,10), Offset(0 +leftmargin +75 +25,10), paint); //右袖枠
    canvas.drawLine(Offset(0 +leftmargin +80,10+ 40), Offset(0 +leftmargin +80 +20,10 +40), paint);
    canvas.drawLine(Offset(0 +leftmargin +100,10), Offset(0 +leftmargin +100,10 +40), paint);
    canvas.drawLine(Offset(0 +leftmargin +75,10), Offset(0 +leftmargin +75,10 +10), paint);
    canvas.drawLine(Offset(0 +leftmargin +20,10 +40), Offset(0 +leftmargin +20,10 +40 +80), paint); //胴枠
    canvas.drawLine(Offset(0 +leftmargin +80,10+ 40), Offset(0 +leftmargin +80,10 +40 +80), paint);
    canvas.drawLine(Offset(0 +leftmargin +25,10 +10), Offset(0 +leftmargin +75,10 +10), paint);

    // bottoms の描画
    paint.color = Color(int.parse(bottomscolor, radix: 16));
    canvas.drawRect(Rect.fromLTWH(20+leftmargin, 0 +topssize,40,36), paint);
    canvas.drawRect(Rect.fromLTWH(55+leftmargin, 0 +topssize,25,100), paint);
    canvas.drawRect(Rect.fromLTWH(20+leftmargin, 0 +topssize,25,100), paint);

    // bottoms の線
    path.moveTo(20 +leftmargin, 0 +topssize);
    path.lineTo(80 +leftmargin, 0 +topssize);
    path.lineTo(80 +leftmargin, 100 +topssize);
    path.lineTo(55 +leftmargin, 100 +topssize);
    path.lineTo(55 +leftmargin, 36 +topssize);
    path.lineTo(45 +leftmargin, 36 +topssize);
    path.lineTo(45 +leftmargin, 100 +topssize);
    path.lineTo(20 +leftmargin, 100 +topssize);
    path.close();

    canvas.drawPath(path, outlinePaint);

    // shoes の描画
    paint.color = Color(int.parse(shoescolor, radix: 16));
    canvas.drawRect(Rect.fromLTWH(10 +leftmargin,0 +topssize +bottomssize,35,23), paint);
    canvas.drawRect(Rect.fromLTWH(55 +leftmargin,0 +topssize +bottomssize,35,23), paint);


    // shoes
    path.moveTo(10 +leftmargin, 0 +topssize +bottomssize);
    path.lineTo(45 +leftmargin, 0 +topssize +bottomssize);
    path.lineTo(45 +leftmargin, 23 +topssize +bottomssize);
    path.lineTo(10 +leftmargin, 23 +topssize +bottomssize);
    path.close();

    path.moveTo(55 +leftmargin, 0 +topssize +bottomssize);
    path.lineTo(90 +leftmargin, 0 +topssize +bottomssize);
    path.lineTo(90 +leftmargin, 23 +topssize +bottomssize);
    path.lineTo(55 +leftmargin, 23 +topssize +bottomssize);
    path.close();



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
    canvas.drawRect(Rect.fromLTWH(20+device_width -leftmargin -100, 0 +topssize,40,36), paint);
    canvas.drawRect(Rect.fromLTWH(55+device_width -leftmargin -100, 0 +topssize,25,100), paint);
    canvas.drawRect(Rect.fromLTWH(20+device_width -leftmargin -100, 0 +topssize,25,100), paint);

    // bottoms
    path.moveTo(40 +device_width -leftmargin -100, 0 +topssize);
    path.lineTo(60 +device_width -leftmargin -100, 0 +topssize);
    path.close();
    path.moveTo(80 +device_width -leftmargin -100, 159);
    path.lineTo(80 +device_width -leftmargin -100, 100 +topssize);
    path.lineTo(55 +device_width -leftmargin -100, 100 +topssize);
    path.lineTo(55 +device_width -leftmargin -100, 36 +topssize);
    path.lineTo(45 +device_width -leftmargin -100, 36 +topssize);
    path.lineTo(45 +device_width -leftmargin -100, 100 +topssize);
    path.lineTo(20 +device_width -leftmargin -100, 100 +topssize);
    path.lineTo(20 +device_width -leftmargin -100, 159);

    canvas.drawPath(path, outlinePaint);

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
    pathleft.lineTo(-25 +device_width -leftmargin -100, 125);
    pathleft.lineTo(-5 +device_width -leftmargin -100, 130);
    pathleft.lineTo(20 +device_width -leftmargin -100, 14);
    pathleft.close();
    canvas.drawPath(pathleft, paint);
    var pathright = Path();
    pathright.moveTo(100 +device_width -leftmargin -100, 9);
    pathright.lineTo(125 +device_width -leftmargin -100, 125);
    pathright.lineTo(105 +device_width -leftmargin -100, 130);
    pathright.lineTo(80 +device_width -leftmargin -100, 14);
    pathright.close();
    canvas.drawPath(pathright, paint);

    // 線で囲う

    // outer
    path.moveTo(0 +device_width -leftmargin -100, 9);
    path.lineTo(40+device_width -leftmargin -100, 9);
    path.lineTo(40+device_width -leftmargin -100, 12);
    path.lineTo(60+device_width -leftmargin -100, 12);
    path.lineTo(60+device_width -leftmargin -100, 9);
    path.lineTo(100+device_width -leftmargin -100, 9);
    path.lineTo(125+device_width -leftmargin -100, 125);
    path.lineTo(105+device_width -leftmargin -100, 130);
    path.lineTo(100 +device_width -leftmargin -100, 107);
    path.lineTo(100 +device_width -leftmargin -100, 159);
    path.lineTo(60 +device_width -leftmargin -100, 159);
    path.lineTo(60 +device_width -leftmargin -100, 20);
    path.lineTo(40 +device_width -leftmargin -100, 20);
    path.lineTo(40 +device_width -leftmargin -100, 159);
    path.lineTo(0 +device_width -leftmargin -100, 159);
    path.lineTo(0 +device_width -leftmargin -100, 107);
    path.lineTo(-5 +device_width -leftmargin -100, 130);
    path.lineTo(-25 +device_width -leftmargin -100, 125);
    path.close();

    // shoes
    path.moveTo(10 +device_width -leftmargin -100, 0 +topssize +bottomssize);
    path.lineTo(45 +device_width -leftmargin -100, 0 +topssize +bottomssize);
    path.lineTo(45 +device_width -leftmargin -100, 23 +topssize +bottomssize);
    path.lineTo(10 +device_width -leftmargin -100, 23 +topssize +bottomssize);
    path.close();

    path.moveTo(55 +device_width -leftmargin -100, 0 +topssize +bottomssize);
    path.lineTo(90 +device_width -leftmargin -100, 0 +topssize +bottomssize);
    path.lineTo(90 +device_width -leftmargin -100, 23 +topssize +bottomssize);
    path.lineTo(55 +device_width -leftmargin -100, 23 +topssize +bottomssize);
    path.close();

    path.moveTo(45 +device_width -leftmargin -100, 162);
    path.lineTo(55 +device_width -leftmargin -100, 162);
    path.close();

    canvas.drawPath(path, outlinePaint);


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
            painter: _MyPainterBody(colors[0], colors[1], colors[2], colors[3], device_width, device_height),
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