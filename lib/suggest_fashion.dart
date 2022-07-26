import 'package:flutter/material.dart';
import 'dart:math';

class SuggestFashion extends StatelessWidget{
  List<String> tops = [
    "シャツ",
    "ニット・セーター",
    "カーディガン",
    "カットソー",
    "Tシャツ",
    "タンクトップ",
    "ベスト",
    "その他トップス"
  ];
  @override
  Widget build(BuildContext context) {
    var intValue = Random().nextInt(tops.length);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('NANIKIRU'),
      ),
      body: Column(
        children: <Widget>[
          Text('トップス：'+tops[intValue]),
          Text('アウター：コート'),
          Text('ボトムス：Gパン'),
          Text('シューズ：スニーカー'),
          Text('アクセサリー：ハット'),
          Text('バック：なし'),
        ],
      ),
    );
  }


}