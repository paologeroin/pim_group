import 'package:flutter/material.dart';
import 'package:pim_group/models/drinks/drinkDB.dart';
import 'package:pim_group/models/goals/goalProvider.dart';
import 'package:pim_group/models/profile/profileInfo_provider.dart';
import 'package:pim_group/models/sleep/sleep_provider.dart';
import 'package:pim_group/pages/LoginPage.dart';
import 'package:pim_group/services/impact.dart';
import 'package:pim_group/utils/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:pim_group/models/db_sleep.dart';
import 'package:pim_group/models/repo/app_repository.dart';


Future<void> main() async {
  //This is a special method that use WidgetFlutterBinding to interact with the Flutter engine. 
  //This is needed when you need to interact with the native core of the app.
  //Here, we need it since when need to initialize the DB before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  //This opens the database.
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  //This creates a new DatabaseRepository from the AppDatabase instance just initialized
  final databaseRepository = AppDatabaseRepository(database: database);

  //Here, we run the app and we provide to the whole widget tree the instance of the DatabaseRepository. 
  //That instance will be then shared through the platform and will be unique.
  runApp(ChangeNotifierProvider<AppDatabaseRepository>(
    create: (context) => databaseRepository,
    child: MyApp(),
  ));
} //main


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
        // ChangeNotifierProvider<SleepProvider>(
        //   create: (context) => SleepProvider(
        //     Provider.of<ImpactService>(context, listen: false),
        //     Provider.of<AppDatabaseRepository>(context, listen: false).database,),
        // ), //SleepProvider
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
