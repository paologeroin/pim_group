import 'package:flutter/material.dart';
import 'package:pim_group/models/drinks/drinkDB.dart';
import 'package:pim_group/models/goals/goalProvider.dart';
import 'package:pim_group/models/profile/profileInfo_provider.dart';
import 'package:pim_group/models/sleep/sleep_provider.dart';
import 'package:pim_group/pages/LoginPage.dart';
import 'package:pim_group/services/impact.dart';
import 'package:pim_group/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

/// Defition of MyApp class
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DrinkDB>(
          create: (context) => DrinkDB(),
        ), //DrinkProvider
        ChangeNotifierProvider<GoalProvider>(
          create: (context) => GoalProvider(),
        ), //GoalProvider
        ChangeNotifierProvider<SleepProvider>(
          create: (context) => SleepProvider(),
        ), //SleepProvider
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(),
        ), //Profile Provider
        Provider(
          create: (context) => Preferences()..init(),
          // This creates the preferences when the provider is creater. With lazy = true (default), the preferences would be initialized when first accessed, but we need them for the other services
          lazy: false,
        ),
        Provider(
            create: (context) => ImpactService(
                  // We pass the newly created preferences to the service
                  Provider.of<Preferences>(context, listen: false),
                )),
      ],
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
