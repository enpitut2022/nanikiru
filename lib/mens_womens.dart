import 'package:flutter/material.dart';
import 'mens.dart';
import 'womens.dart';

class MensWomens extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('NANIKIRU'),
      ),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
    Text('性別を選択',
    style: TextStyle(
    fontSize: 20
    ),
    ),

    ElevatedButton(
    onPressed: (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MensPage()),
    );
    },
    child: const Text('男性'),
    ),
    ElevatedButton(
    onPressed: (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => WomensPage()),
    );
    },
    child: const Text('女性'),
    ),
    ],
    ),
    );
  }


}