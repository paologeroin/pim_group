//Imports that are necessary to the code generator of floor
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:pim_group/models/typeConverters/dateTimeConverter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:pim_group/models/daos/daos.dart';
import 'entities/entities.dart';

//Here, we are importing the entities and the daos of the database

part 'db_sleep.g.dart'; // the generated code will be there

//Here we are saying that this is the first version of the Database and it has just 1 entity, i.e., Meal.
//We also added a TypeConverter to manage the DateTime of a Meal entry, since DateTimes are not natively
//supported by Floor.
@TypeConverters([DateTimeConverter])
@Database(version: 5, entities: [Drink, Sleep, Levels, Data])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  DrinkDao get drinkDao;
  SleepDao get sleepDao;
  LevelsDao get levelDao;
  DataDao get dataDao;
}//AppDatabase
