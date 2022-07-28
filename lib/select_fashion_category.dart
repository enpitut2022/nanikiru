import 'package:flutter/material.dart';
import 'package:nanikiru/select_register_fashion.dart';
import 'next_page.dart';

import 'fahion_list.dart';
import 'accessories.dart';
import 'bag.dart';
import 'bottoms.dart';
import 'dress.dart';
import 'outer.dart';
import 'shoose.dart';
import 'tops.dart';

class SelectRegisterFashion extends StatelessWidget{
  SelectRegisterFashion(this.men);
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
              MaterialPageRoute(builder: (context) => ThirdPage(men)),
            );
          },
          child: const Text('トップス'),

        ), ElevatedButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdPage(men)),
            );
          },
          child: const Text('ボトムス'),

        ),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThirdPage(men)),
              );
            },
            child: const Text('アウター'),

          ), ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThirdPage(men)),
              );
            },
            child: const Text('シューズ'),

          ),
        ],

      ),)
    );
  }


}