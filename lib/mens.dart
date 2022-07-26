import 'package:flutter/material.dart';

class MensPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('NANIKIRU'),
      ),
      body: Container(
        color: Colors.white,
          child: const Text('男性')
      ),

    );
  }


}