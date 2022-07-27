import 'package:flutter/material.dart';
import 'next_page.dart';
import 'register_fashion.dart';
import 'fahion_list.dart';
import 'select_fashion_category.dart';
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
              MaterialPageRoute(builder: (context) => NextPage()),
            );
          },
          child: const Text('服を選ぶ'),

        ), ElevatedButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdPage()),
            );
          },
          child: const Text('登録'),

        ),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FlutterDemo_2(storage: CounterStorage2())),
              );
            },
            child: const Text('登録服一覧'),

          )],

      ),
    );
  }


}