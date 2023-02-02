import 'package:cmdapp/cmd.dart';
import 'package:cmdapp/cmddd.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyApp',
      home: Cmd1(),
    );
  }
}
