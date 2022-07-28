import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import '../utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nanikiru/fahion_list.dart';
import 'dart:developer' as developer;

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
          // print(fashion_map);

        }
        // fashion_map.forEach((String key, List value){
          for (var key in fashion_map.keys) {
            fashion_map[key].removeAt(0);
            print(fashion_map);
          };

        // });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
          ],
      ),
    );
  }
}
