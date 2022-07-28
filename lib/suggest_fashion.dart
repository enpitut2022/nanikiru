import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import '../utils/constants.dart';

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
            Text(category.keys.elementAt(i)+":"+category[category.keys.elementAt(i)][rand_nums[i]])
        ],
      ),
    );
  }


}