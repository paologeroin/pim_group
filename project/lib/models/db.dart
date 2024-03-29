import 'dart:async';
import 'package:floor/floor.dart';
import 'package:pim_group/models/typeConverters/dateTimeConverter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:pim_group/models/daos/daos.dart';
import 'entities/entities.dart';

part 'db.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 6, entities: [Drink, Sleep, Goal])
abstract class AppDatabase extends FloorDatabase {
  DrinkDao get drinkDao;
  SleepDao get sleepDao;
  GoalDao get goalDao;
}//AppDatabase
