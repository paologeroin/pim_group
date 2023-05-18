import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pim_group/models/sleep/sleepDB.dart';

// this is the change notifier. it will manage all the logic of the home page:
// fetching the correct data from the database and on
// startup fetching the data from the online services
class SleepProvider extends ChangeNotifier{
  // Data to be used by the UI
  late List<StartTime> startTime;
  late List<EndTime> endTime;
  late List<sleepDuration> durationValue;
  late List<MinutesAsleep> minutesAsleep;
  late List<MinutesAwake> minutesAwake;
  late int efficiency;
  // There will be a privite part that is used only by the sleep_provider
  // data fetched from external services or db
  late List<StartTime> _startTimeDB;
  late List<EndTime> _endTimeDB;
  late List<sleepDuration> _durationValueDB;
  late List<MinutesAsleep> _minutesAsleepDB;
  late List<MinutesAwake> _minutesAwakeDB;
  late int _efficiencyDB; //serve?
  // selected day of data to be shown
  DateTime dateOfSleep = DateTime.now();
  
  // data generators faking external services
  final FitbitGen fitbitGen = FitbitGen(); // genera dati casuali di duration
  final Random _random = Random();

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  // HomeProvider() {
  //   _fetchAndCalculate();
  //   getDataOfDay(dateOfSleep);
  // }

  // method to fetch all data and calculate the exposure
  // void _fetchAndCalculate() {
  //   _durationValueDB = fitbitGen.fetchSleepDuration();
  // }

  // method to trigger a new data fetching
  // void refresh() {
  //   _fetchAndCalculate();
  //   getDataOfDay(dateOfSleep);
  // }

  // Constructor of provider which manages the fetching of all data from th
  // servers and then notifies the ui to build


  // Methods


  // sistemare questa parte
    // method to select only the data of the chosen day
    // Oltre che un sorter è anche un filter
    void getDataOfDay(DateTime dateOfSleep) {
      this.dateOfSleep = dateOfSleep;
      durationValue = _durationValueDB
          .where((element) => element.timestamp.day == dateOfSleep.day)
          .toList()
          .reversed
          .toList();
      // pm25 = _pm25DB
      //     .where((element) => element.timestamp.day == showDate.day)
      //     .toList()
      //     .reversed
      //     .toList();
      // exposure = _exposureDB
      //     .where((element) => element.timestamp.day == showDate.day)
      //     .toList()
      //     .reversed
      //     .toList();
      // fullexposure = exposure.map((e) => e.value).reduce(
      //       (value, element) => value + element,
      //     );
      // after selecting all data we notify all consumers to rebuild
     notifyListeners(); 
    }
} //SleepProvider