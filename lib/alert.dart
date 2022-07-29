import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class AlertDialogSample extends StatelessWidget {
  const AlertDialogSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('服の追加'),
      content: Text('服を追加しました。'),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}