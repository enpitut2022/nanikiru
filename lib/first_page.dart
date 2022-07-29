import 'package:flutter/material.dart';
import 'package:nanikiru/fahion_list.dart';
import 'package:nanikiru/suggest_fashion.dart';
import 'tops.dart';
import 'next_page.dart';
import 'select_fashion_category.dart';
import 'select_view_register_fashion.dart';

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
            SizedBox(width:230,
              height:50,
            child:ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuggestFashion(men, storage: CounterStorage(men))),
                );
              },
              child: const Text('候補のファッションを見る'),
            ),),
            SizedBox(width:230,
            height:50,
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdPage(men)),
                );
              },
              child: const Text('服を登録'),
            ),),
      SizedBox(width:230,
        height:50,
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectViewRegisterFashion(men)),
                );
              },
              child: const Text('服一覧'),
            ),),
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
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width:180, height: 50.0, child:
          RadioListTile(
            title: Text('メンズ'),
            value: true,
            groupValue: men,
            onChanged: (value) => _onRadioSelected(value)
          ),

    ),
          SizedBox(width:180, height: 50.0, child:
          RadioListTile(
              title: Text('レディース'),
              value: false,
              groupValue: men,
              onChanged: (value) => _onRadioSelected(value)
          ),
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