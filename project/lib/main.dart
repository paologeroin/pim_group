import 'package:flutter/material.dart';
import 'pages/root.dart';

void main() {
  runApp(const MyApp());
}

/// Defition of MyApp class
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // turning off the debug mode
      debugShowCheckedModeBanner: false,
      // first default widget when the app is started
      home: const Root(),
      // theme color of upbar and buttoms
      theme: ThemeData(primarySwatch: Colors.blue)
    );
  }
}