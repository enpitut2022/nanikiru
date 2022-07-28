import 'package:flutter/material.dart';
import 'package:nanikiru/select_view_register_fashion.dart';
import 'next_page.dart';

import 'fahion_list.dart';
import 'accessories.dart';
import 'bag.dart';
import 'bottoms.dart';
import 'dress.dart';
import 'outer.dart';
import 'shoose.dart';
import 'tops.dart';

class RegisterFashion extends StatelessWidget{
  RegisterFashion(this.men);
  bool men;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('NANIKIRU'),
        backgroundColor: Color(0xff81d4fa),
      ),
      body: Center(
        child:Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              MaterialPageRoute(builder: (context) => FlutterDemo_bottoms(storage: CounterStorage_bottoms(men))),
            );
          },
          child: const Text('ボトムス'),

        ),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>FlutterDemo_outer(storage: CounterStorage_outer())),
              );
            },
            child: const Text('アウター'),

          ), ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FlutterDemo_shoose(storage: CounterStorageshoose(men))),
              );
            },
            child: const Text('シューズ'),

          ),
        ],

      ),)
    );
  }


}