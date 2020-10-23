import 'package:flutter/material.dart';

Widget appBar(BuildContext context){
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22,),
      children: <TextSpan>[
        TextSpan(text: 'Voting',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
        TextSpan(text: 'Corner',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigoAccent)),
      ],
    ),
  );
}
