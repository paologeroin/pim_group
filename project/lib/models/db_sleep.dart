//Imports that are necessary to the code generator of floor
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:pim_group/models/typeConverters/dateTimeConverter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:pim_group/models/daos_sleep/daos_sleep.dart';
import 'entities_sleep/entities_sleep.dart';

//Here, we are importing the entities and the daos of the database

part 'db_sleep.g.dart'; // the generated code will be there

//Here we are saying that this is the first version of the Database and it has just 1 entity, i.e., Meal.
//We also added a TypeConverter to manage the DateTime of a Meal entry, since DateTimes are not natively
//supported by Floor.
@TypeConverters([DateTimeConverter])
@Database(version: 5, entities: [SleepDuration, Efficiency, Data, TimeLimit, Minutes, Levels]) //Efficiency, Data, TimeLimit])
abstract class SleepDatabase extends FloorDatabase {
  //Add all the daos as getters here
  SleepDurationDao get sleepDurationDao;
  EfficiencyDao get efficiencyDao;
  DataDao get dataDao; 
  TimeLimitDao get timeLimitDao;
  MinutesDao get minutesDao;
  LevelsDao get levelsDao;
}//AppDatabase
