import 'dart:math';
import 'package:flutter/material.dart';
// import 'package:pim_group/models/sleepDB.dart';

// this is the change notifier. it will manage all the logic of the home page:
// fetching the correct data from the database and on
// startup fetching the data from the online services
class SleepProvider extends ChangeNotifier{
// Data to be used by the UI
// There will be a privite part that is used only by the sleep_provider


// Constructor of provider which manages the fetching of all data from th
// servers and then notifies the ui to build


// Methods


// sistemare questa parte
  // // method to select only the data of the chosen day
  // // Oltre che un sorter è anche un filter
  // void getDataOfDay(DateTime showDate) {
  //   this.showDate = showDate;
  //   heartRates = _heartRatesDB
  //       .where((element) => element.timestamp.day == showDate.day)
  //       .toList()
  //       .reversed
  //       .toList();
  //   pm25 = _pm25DB
  //       .where((element) => element.timestamp.day == showDate.day)
  //       .toList()
  //       .reversed
  //       .toList();
  //   exposure = _exposureDB
  //       .where((element) => element.timestamp.day == showDate.day)
  //       .toList()
  //       .reversed
  //       .toList();
  //   fullexposure = exposure.map((e) => e.value).reduce(
  //         (value, element) => value + element,
  //       );
  //   // after selecting all data we notify all consumers to rebuild
  //   notifyListeners(); 
} //SleepProvider