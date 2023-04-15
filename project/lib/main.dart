import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
} //main

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _example1(),
    );
  } //build

  Widget _example1() => Container(
        color: Colors.red,
      );
}//MyApp