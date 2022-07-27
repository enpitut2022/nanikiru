import 'package:flutter/material.dart';
import 'package:nanikiru/suggest_fashion.dart';
import 'next_page.dart';

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('NANIKIRU'),
      ),
      body: Column(
        children: [ElevatedButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SuggestFashion()),
            );
          },
          child: const Text('服を選ぶ'),

        ), ElevatedButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NextPage()),
            );
          },
          child: const Text('登録'),

        )],

      ),
    );
  }


}