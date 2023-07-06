import 'package:pim_group/models/db_sleep.dart';
import 'package:pim_group/models/entities/entities.dart';
import 'package:flutter/material.dart';

// inspo from the repository design pattern -> fare grafico ER

class AppDatabaseRepository extends ChangeNotifier {
  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  AppDatabaseRepository({required this.database});

  //This method wraps the findAllEfficiencies() method of the DAO
  Future<List<Drink>> findAllDrinks() async {
    final results = await database.drinkDao.findAllDrinks();
    return results;
  } //findAllDrinks

  //Wrap findDrinksOnDate
  Future<List<Drink>> findDrinksOnDate(startTime, endTime) async {
    final results =
        await database.drinkDao.findDrinksOnDate(startTime, endTime);
    return results;
  } //findAllDrinks

  //Wrap findMostRecentDrink
  Future<List<Drink>> findMostRecentDrink() async {
    final results = await database.drinkDao.findMostRecentDrink();
    return results;
  } //findAllDrinks

  //This method wraps the insertMeal() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertDrink(Drink drink) async {
    final results = await database.drinkDao.insertDrink(drink);
    return results;
  } //insertDrink

  //This method wraps the deleteMeal() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> removeDrink(Drink drink) async {
    final results = await database.drinkDao.deleteDrink(drink);
    return results;
  } //removeData

  //This method wraps the updateMeal() method of the DAO.
  //Then, it notifies the listeners that something changed.
  // Future<void> updateData(Data data) async{
  //   final results = await database.dataDao.updateData(data);
  //   return results;
  // }//updateData

  // Here in the repository we are defining the method of the DAO for the goals

  //This method wraps the findAllGoals() method of the DAO
  Future<List<Goal>> findAllGoals() async {
    final results = await database.goalDao.findAllGoals();
    return results;
  } //findAllGoals

  //This method wraps the insertGoal() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertGoal(Goal goal) async {
    await database.goalDao.insertGoal(goal);
    notifyListeners();
  } //insertGoal

  //This method wraps the deleteGoal() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> removeGoal(Goal goal) async {
    await database.goalDao.deleteGoal(goal);
    notifyListeners();
  } //removeGoal

  //This method wraps the updateGoal() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> updateGoal(Goal goal) async {
    await database.goalDao.updateGoal(goal);
    notifyListeners();
  } //updateGoal

  //This method wraps the findAllSleeps() method of the DAO
  Future<List<Sleep>> findAllSleeps() async {
    final results = await database.sleepDao.findAllSleep();
    return results;
  }

  //This method wraps the insertSleep() method of the DAO.
  Future<void> insertSleep(Sleep sleep) async {
    final results = await database.sleepDao.insertSleep(sleep);
    return results;
  } //insertDrink

  //This method wraps the updateSleep() method of the DAO.
  Future<void> updateSleep(Sleep sleep) async {
    await database.sleepDao.updateSleep(sleep);
    notifyListeners();
  } //updateGoal

  //Wrap findDrinksOnDate
  Future<List<Sleep>> findSleepbyDate(date) async {
    final results =
        await database.sleepDao.findSleepbyDate(date);
    return results;
  }
} //SleepDatabaseRepository
