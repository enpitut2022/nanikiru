import 'package:flutter/material.dart';
import 'next_page.dart';

import 'fahion_list.dart';
import 'accessories.dart';
import 'bag.dart';
import 'bottoms.dart';
import 'dress.dart';
import 'outer.dart';
import 'shoose.dart';
import 'tops.dart';

class ThirdPage extends StatelessWidget{
  ThirdPage(this.men);
  bool men;

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
              MaterialPageRoute(builder: (context) => FlutterDemo(storage: CounterStorage(men))),
            );
          },
          child: const Text('トップス'),

        ), ElevatedButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FlutterDemo_bottoms(storage: CounterStorage_bottoms()) ),
            );
          },
          child: const Text('ボトムス'),

        ),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FlutterDemo_outer(storage: CounterStorage_outer())),
              );
            },
            child: const Text('アウター'),

          ), ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FlutterDemo_dress(storage: CounterStorage_dress())),
              );
            },
            child: const Text('ワンピース'),

          ), ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FlutterDemo_shoose(storage: CounterStorageshoose())),
              );
            },
            child: const Text('シューズ'),

          ), ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FlutterDemo_accessories(storage: CounterStorageaccessories(men))),
              );
            },
            child: const Text('アクセサリー'),

          )],

      ),
    );
  }


}