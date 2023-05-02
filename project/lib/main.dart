import 'package:flutter/material.dart';
import 'package:pim_group/models/mealDB.dart';
import 'package:pim_group/pages/HomePage.dart';
import 'pages/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:pim_group/screens/mealpage.dart';
import 'package:pim_group/screens/AddDrinkPage.dart';
import 'pages/root.dart';

void main() {
  runApp( MyApp());
}

/// Defition of MyApp class
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider<MealDB>(
        create: (context) => MealDB(),
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Nav Bar V2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage()),
      

    );
  }
}