import 'package:pim_group/models/db.dart';
import 'package:pim_group/models/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:pim_group/services/sleepData.dart';

class AppDatabaseRepository extends ChangeNotifier {
  final AppDatabase database;

  AppDatabaseRepository({required this.database});

  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));
  late List<Sleep> sleepData;
  late List<Levels> levelData;
  late List<Data> phaseData;

  Future<List<Drink>> findAllDrinks() async {
    final results = await database.drinkDao.findAllDrinks();
    return results;
  } //findAllDrinks

  Future<List<Drink>> findDrinksOnDate(startTime, endTime) async {
    final results =
        await database.drinkDao.findDrinksOnDate(startTime, endTime);
    return results;
  } //findAllDrinks

  Future<List<Drink>> findMostRecentDrink() async {
    final results = await database.drinkDao.findMostRecentDrink();
    return results;
  } //findAllDrinks

  Future<void> insertDrink(Drink drink) async {
    final results = await database.drinkDao.insertDrink(drink);
    return results;
  } //insertDrink

  Future<void> removeDrink(Drink drink) async {
    final results = await database.drinkDao.deleteDrink(drink);
    return results;
  } //removeData

  Future<List<Goal>> findAllGoals() async {
    final results = await database.goalDao.findAllGoals();
    return results;
  } //findAllGoals

  Future<void> insertGoal(Goal goal) async {
    await database.goalDao.insertGoal(goal);
    notifyListeners();
  } //insertGoal

  Future<void> removeGoal(Goal goal) async {
    await database.goalDao.deleteGoal(goal);
    notifyListeners();
  } //removeGoal

  Future<void> updateGoal(Goal goal) async {
    await database.goalDao.updateGoal(goal);
    notifyListeners();
  } //updateGoal

  Future<List<Sleep>> findAllSleeps() async {
    final results = await database.sleepDao.findAllSleep();
    return results;
  }

  Future<void> insertSleep(Sleep sleep) async {
    final results = await database.sleepDao.insertSleep(sleep);
    return results;
  } //insertDrink

  Future<void> updateSleep(Sleep sleep) async {
    await database.sleepDao.updateSleep(sleep);
    notifyListeners();
  } //updateGoal

  Future<List<Sleep>> findSleepbyDate(
      DateTime startTime, DateTime endTime) async {
    final results = await database.sleepDao.findSleepbyDate(startTime, endTime);
    return results;
  } //findSleepbyDate

  Future<Sleep?> findFirstDayInDb() async {
    final results = await database.sleepDao.findFirstDayInDb();
    return results;
  } //findFirstDayInDb

  Future<Sleep?> findLastDayInDb() async {
    final results = await database.sleepDao.findLastDayInDb();
    return results;
  } //findLastDayInDb

  Future<List<Data>> findAllData() async {
    final results = await database.dataDao.findAllData();
    return results;
  } //findAllData

  Future<void> getDataOfDay(DateTime showDate) async {
    var firstDay = await database.sleepDao.findFirstDayInDb();
    var lastDay = await database.sleepDao.findLastDayInDb();
    if (showDate.isAfter(lastDay!.startTime as DateTime) ||
        showDate.isBefore(firstDay!.endTime as DateTime)) return;

    this.showDate = showDate;
    sleepData = await database.sleepDao.findSleepbyDate(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    levelData = await database.levelDao.findLevelsbyDate(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));

    phaseData = await database.dataDao.findDatabyDate(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
  } //getDataOfDay
} //SleepDatabaseRepository
