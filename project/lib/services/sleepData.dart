//troveremo un modo per definire sto file
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/server_strings.dart';
import 'impact.dart';

class SleepData{
   final String dateOfSleep;
   final String startTime;
   final String endTime;
   final double duration;
   final int minutesToFallAsleep;
   final int minutesAsleep;
   final int minutesAwake;
   final int minutesAfterWakeup;
   final int efficiency;
   final String logType;
   final bool mainSleep;
   final Map levels;
   //final Map data;

  SleepData(this.dateOfSleep,this.startTime, this.endTime, this.duration, this.minutesToFallAsleep, this.minutesAsleep,
  this.minutesAwake, this.minutesAfterWakeup, this.efficiency,this.logType, this.mainSleep, this.levels);

  SleepData.fromJson(String date, Map<String, dynamic> jsonMap) :
      dateOfSleep = ('$date ${jsonMap["dateOfSleep"]}'),
      startTime = ('$date ${jsonMap["startTime"]}'),
      endTime = ('$date ${jsonMap["endTime"]}'),
      duration = jsonMap["duration"],
      minutesToFallAsleep = jsonMap["minutesToFallAsleep"],
      minutesAsleep = jsonMap["minutesAsleep"],
      minutesAwake = jsonMap["minutesAwake"],
      minutesAfterWakeup = jsonMap["minutesAfterWakeup"],
      efficiency = jsonMap["efficiency"],
      logType = jsonMap["logType"].toString(),
      mainSleep = jsonMap["mainSleep"],
      levels = jsonMap["levels"];
      // non serve data
      // data = jsonMap["levels"]["data"]; //come inizializzare
      

  // @override
  // String toString() {
  //   return 'SleepData(time: $dateOfSleep, startTime: $startTime, )';
  // }//toString
}//SleepData