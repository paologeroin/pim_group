import 'package:flutter/material.dart';
import 'package:pim_group/models/drinkDB.dart';
import 'package:pim_group/pages/HomePage.dart';
import 'pages/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:pim_group/drink_screens/drinkpage.dart';
import 'package:pim_group/drink_screens/AddDrinkPage.dart';
import 'pages/root.dart';

void main() {
  runApp(MyApp());
}

/// Defition of MyApp class
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DrinkDB>(
      create: (context) => DrinkDB(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bottom Nav Bar V2',
          theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: LoginPage()),
    );
  }
}
