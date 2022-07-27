import 'package:flutter/material.dart';
import 'package:nanikiru/suggest_fashion.dart';
import 'next_page.dart';

bool men = true;

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('NANIKIRU'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuggestFashion(men)),
                );
              },
              child: const Text('候補のファッションを見る'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
              child: const Text('服を登録'),
            ),
            RadioButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class RadioButtonWidget extends StatefulWidget{
  @override
  _GenderState createState() => _GenderState();
}


class _GenderState extends State<RadioButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            SizedBox(height: 50.0,),
            RadioListTile(
              title: Text('男性'),
              value: true,
              groupValue: men,
              onChanged: (value) => _onRadioSelected(value),
            ),
            RadioListTile(
              title: Text('女性'),
              value: false,
              groupValue: men,
              onChanged: (value) => _onRadioSelected(value),
            ),
      ]
    );
  }
  _onRadioSelected(value) {
    setState(() {
      men = value;
    });
  }
}