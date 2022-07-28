import 'package:flutter/material.dart';
import 'next_page.dart';
import "register_fashion.dart";
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
          backgroundColor: Color(0xff81d4fa),
        ),
        body: Center(
          child:Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlutterDemo_2(storage: CounterStorage2())),
                );
              },
              child: const Text('トップス'),

            ), ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlutterDemo_2(storage: CounterStorage2()) ),
                );
              },
              child: const Text('ボトムス'),

            ),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FlutterDemo_2(storage: CounterStorage2())),
                  );
                },
                child: const Text('アウター'),

              ), ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FlutterDemo_2(storage: CounterStorage2())),
                  );
                },
                child: const Text('シューズ'),

              ),
            ],

          ),)
    );
  }


}