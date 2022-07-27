import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import '../utils/constants.dart';

class SuggestFashion extends StatelessWidget{
  Map men_category = Constants().men_category;
  Map women_category = Constants().women_category;

  @override
  Widget build(BuildContext context) {
    List rand_nums = [];
    men_category.forEach((key, value) {
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
            Text(men_category.keys.elementAt(i)+":"+men_category[men_category.keys.elementAt(i)][rand_nums[i]])
        ],
      ),
    );
  }


}