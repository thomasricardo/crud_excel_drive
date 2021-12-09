import 'package:flutter/material.dart';
import 'googlesheet.dart';
import 'mainscreen.dart';

void main() async {
  await FlutterSheet.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}