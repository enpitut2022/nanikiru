import 'package:flutter/material.dart';
import "register_fashion.dart";
import 'fahion_list.dart';

class SelectViewRegisterFashion extends StatelessWidget{
  SelectViewRegisterFashion(this.men);
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
                  MaterialPageRoute(builder: (context) =>  FlutterDemo_list('tops' ,storage: CounterStorage_list())),
                );
              },
              child: const Text('トップス'),

            ), ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  FlutterDemo_list('bottoms' ,storage: CounterStorage_list())),
                );
              },
              child: const Text('ボトムス'),

            ),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  FlutterDemo_list('outer', storage: CounterStorage_list())),
                  );
                },
                child: const Text('アウター'),

              ), ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FlutterDemo_list('shoes',storage: CounterStorage_list())),
                  );
                },
                child: const Text('シューズ'),

              ),
            ],

          ),)
    );
  }


}