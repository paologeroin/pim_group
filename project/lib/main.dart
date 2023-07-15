import 'package:flutter/material.dart';
import 'package:pim_group/models/profile/profileInfo_provider.dart';
import 'package:pim_group/pages/LoginPage.dart';
import 'package:pim_group/services/impact.dart';
import 'package:pim_group/utils/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:pim_group/models/db.dart';
import 'package:pim_group/models/repo/app_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final databaseRepository = AppDatabaseRepository(database: database);
  runApp(ChangeNotifierProvider<AppDatabaseRepository>(
    create: (context) => databaseRepository,
    child: MyApp(),
  ));
} //main

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(),
        ),
        Provider(
          create: (context) => Preferences()..init(),
          lazy: false,
        ),
        Provider(
            create: (context) => ImpactService(
                  Provider.of<Preferences>(context, listen: false),
                )),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bottom Nav Bar V2',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: LoginPage()),
    );
  }
} // MyApp
