import 'package:pim_group/models/db_sleep.dart';
import 'package:pim_group/models/entities_sleep/entities_sleep.dart';
import 'package:flutter/material.dart';

// inspo from the repository design pattern -> fare grafico ER

class SleepDatabaseRepository extends ChangeNotifier{

  //The state of the database is just the AppDatabase
  final SleepDatabase sleepdatabase;

  //Default constructor
  SleepDatabaseRepository({required this.sleepdatabase});

  //This method wraps the findAllEfficiencies() method of the DAO
  Future<List<Efficiency>> findAllEfficiencies() async{
    final results = await sleepdatabase.efficiencyDao.findAllEfficiencies();
    return results;
  }//findAllEfficiencies
  Future<List<Levels>> findAllLevels() async{
    final results = await sleepdatabase.levelsDao.findAllLevels();
    return results;
  }//findAllLevels
  Future<List<Minutes>> findAllMinutes() async{
    final results = await sleepdatabase.minutesDao.findAllMinutes();
    return results;
  }//findAllMinutes
  Future<List<TimeLimit>> findAllTimeLimit() async{
    final results = await sleepdatabase.timeLimitDao.findAllTimeLimit();
    return results;
  }//findAllTimeLimit
  Future<List<SleepDuration>> findAllSleepDuration() async{
    final results = await sleepdatabase.sleepDurationDao.findAllSleepDuration();
    return results;
  }//findAllSleepDuration
   Future<List<Data>> findAllData() async{
    final results = await sleepdatabase.dataDao.findAllData();
    return results;
  }//findAllData

  //This method wraps the insertMeal() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> insertEfficiencies(Efficiency efficiency)async {
    await sleepdatabase.efficiencyDao.insertEfficiency(efficiency);
    notifyListeners();
  }//insertEfficiencies
  Future<void> insertLevels(Levels levels) async{
    final results = await sleepdatabase.levelsDao.insertLevels(levels);
    return results;
  }//insertLevels
  Future<void> insertMinutes(Minutes minutes) async{
    final results = await sleepdatabase.minutesDao.insertMinutes(minutes);
    return results;
  }//insertMinutes
  Future<void> insertTimeLimit(TimeLimit timeLimit) async{
    final results = await sleepdatabase.timeLimitDao.insertTimeLimit(timeLimit);
    return results;
  }//insertTimeLimit
  Future<void> insertSleepDuration(SleepDuration sleepDurations) async{
    final results = await sleepdatabase.sleepDurationDao.insertSleepDuration(sleepDurations);
    return results;
  }//insertSleepDuration
  Future<void> insertData(Data data) async{
    final results = await sleepdatabase.dataDao.insertData(data);
    return results;
  }//insertData

  //This method wraps the deleteMeal() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> removeEfficiencies(Efficiency efficiency) async{
    await sleepdatabase.efficiencyDao.deleteEfficiency(efficiency);
    notifyListeners();
  }//removeEfficiencies
  Future<void> removeLevels(Levels levels) async{
    final results = await sleepdatabase.levelsDao.deleteLevels(levels);
    return results;
  }//removeLevels
  Future<void> removeMinutes(Minutes minutes) async{
    final results = await sleepdatabase.minutesDao.deleteMinutes(minutes);
    return results;
  }//removeMinutes
  Future<void> removeTimeLimit(TimeLimit timeLimit) async{
    final results = await sleepdatabase.timeLimitDao.deleteTimeLimit(timeLimit);
    return results;
  }//removeTimeLimit
  Future<void> removeSleepDuration(SleepDuration sleepDurations) async{
    final results = await sleepdatabase.sleepDurationDao.deleteSleepDuration(sleepDurations);
    return results;
  }//removeSleepDuration
  Future<void> removeData(Data data) async{
    final results = await sleepdatabase.dataDao.deleteData(data);
    return results;
  }//removeData

  //This method wraps the updateMeal() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> updateEfficiencies(Efficiency efficiency) async{
    await sleepdatabase.efficiencyDao.updateEfficiency(efficiency);
    notifyListeners();
  }//updateEfficiencies
  Future<void> updateLevels(Levels levels) async{
    final results = await sleepdatabase.levelsDao.updateLevels(levels);
    return results;
  }//updateLevels
  Future<void> updateMinutes(Minutes minutes) async{
    final results = await sleepdatabase.minutesDao.updateMinutes(minutes);
    return results;
  }//updateMinutes
  Future<void> updateTimeLimit(TimeLimit timeLimit) async{
    final results = await sleepdatabase.timeLimitDao.updateTimeLimit(timeLimit);
    return results;
  }//updateTimeLimit
  Future<void> updateSleepDuration(SleepDuration sleepDurations) async{
    final results = await sleepdatabase.sleepDurationDao.updateSleepDuration(sleepDurations);
    return results;
  }//updateSleepDuration
  Future<void> updateData(Data data) async{
    final results = await sleepdatabase.dataDao.updateData(data);
    return results;
  }//updateData

}//SleepDatabaseRepository