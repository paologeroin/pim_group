import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pim_group/models/entities_sleep/entities_sleep.dart';
import 'package:pim_group/models/db_sleep.dart';
import 'package:pim_group/services/impact.dart';
import 'package:pim_group/utils/server_strings.dart';
import '../daos_sleep/daos_sleep.dart';

// this is the change notifier. it will manage all the logic of the home page:
// fetching the correct data from the database and on
// startup fetching the data from the online services
class SleepProvider extends ChangeNotifier{
  // Data to be used by the UI

  late List<Sleep> sleep;
  late List<Levels> level;
  late List<Data> data;
  final AppDatabase sleepDB;

  // There will be a privite part that is used only by the sleep_provider
  // data fetched from external services or db
  late List<Sleep> _sleep;
  late List<Levels> _level;
  late List<Data> _data;

  // selected day of data to be shown
  DateTime dateOfSleep = DateTime.now().subtract(const Duration(days: 1));
  late DateTime lastFetch;
  final ImpactService impactService; // mi ha fatto aggiungere il late(?)
  bool doneInit = false;

  SleepProvider(this.impactService, this.sleepDB) {
    _init();
  }

  // constructor of provider which manages the fetching of all data
  // from the servers and then notifies the ui to build
  Future<void> _init() async {
    await _fetch();
    await getDataOfDay(dateOfSleep);
    doneInit = true;
    notifyListeners();
  }//_init

  Future<DateTime?> _getLastFetch() async {
    var sleepData = await sleepDB.sleepDao.findAllSleep();
    if (sleepData.isEmpty) {
      return null;
    }
    return sleepData.last.dateOfSleep;
    }//_getLastFetch
  
  // method to fetch all data
  Future<void> _fetch() async {
    lastFetch = await _getLastFetch() ??
        DateTime.now().subtract(const Duration(days: 2));
    // do nothing if already fetched
    if (lastFetch.day == DateTime.now().subtract(const Duration(days: 1)).day) {
      return;
    }
    _sleep = await impactService.getDataFromDay(lastFetch);
    for (var element in _sleep) {
      sleepDB.sleepDao.insertSleep(element);
    } // db add to the table
    for (var element in _sleep) {
      sleepDB.sleepDao.insertSleep(element);
    }
    for (var element in _level) {
      sleepDB.levelDao.insertLevels(element);
    }
    for (var element in _data) {
      sleepDB.dataDao.insertData(element);
    }
  }

  // method to trigger a new data fetching
  Future<void> refresh() async {
    await _fetch();
    await getDataOfDay(dateOfSleep);
  }//refresh

  // method to select only the data of the chosen day
  Future<void> getDataOfDay(DateTime showDate) async {
    // check if the day we want to show has data
    var firstDay = await sleepDB.sleepDao.findFirstDayInDb();
    var lastDay = await sleepDB.sleepDao.findLastDayInDb();
    if (showDate.isAfter(lastDay!.dateOfSleep) ||
        showDate.isBefore(firstDay!.dateOfSleep)) return;
        
    this.dateOfSleep = dateOfSleep;
    sleep = await sleepDB.sleepDao.findSleepbyDate(
      DateUtils.dateOnly(dateOfSleep),
      DateTime(dateOfSleep.year, dateOfSleep.month, dateOfSleep.day, 23, 59)
    );
    level = await sleepDB.levelDao.findLevelsbyDate(
      DateUtils.dateOnly(dateOfSleep),
      DateTime(dateOfSleep.year, dateOfSleep.month, dateOfSleep.day, 23, 59)
    );
    data = await sleepDB.dataDao.findDatabyDate(
      DateUtils.dateOnly(dateOfSleep),
      DateTime(dateOfSleep.year, dateOfSleep.month, dateOfSleep.day, 23, 59)
    );
  }//getDataOfDay

  Future<Future<int?>> getAwakeCount(int sleepId) async {
    final sleepDao = sleepDB.levelDao;
    return sleepDao.getAwakeCount(sleepId);
  }
} //SleepProvider