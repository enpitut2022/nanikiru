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

  Map men_category = Constants().men_category;
  Map women_category = Constants().women_category;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) {
      setState(() {
        fashion_list = value.split('\n');
        fashion_list.removeLast();
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

    int tops_rand = 0;
    if (fashion_list.length > 0) {
      tops_rand = Random().nextInt(fashion_list.length);
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('NANIKIRU'),
      ),
      body: Column(
        children: <Widget>[
          Text(category.keys.elementAt(0)+":"+fashion_list[tops_rand]),
          for (var i = 1; i <= 3; i++)
            Text(category.keys.elementAt(i)+":"+category[category.keys.elementAt(i)][rand_nums[i]])
        ],
      ),
    );
  }
}
