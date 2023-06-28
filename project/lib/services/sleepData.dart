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
  // final String dateOfSleep;
  // final String startTime;
  // final String endTime;
  // final int duration;
  // final int minutesToFallAsleep;
  // final int minutesAsleep;
  // final int minutesAwake;
  // final int minutesAfterWakeup;
  final int efficiency;
  // final String logType;
  // final bool mainSleep;
  // final List levels;
  // final List data;


  // da aggiungere
  // this.dateOfSleep,this.startTime, this.endTime, this.duration, this.minutesToFallAsleep, this.minutesAsleep,
  // this.minutesAwake, this.minutesAfterWakeup

  SleepData(this.efficiency,);
  // this.logType, this.mainSleep, this.levels, this.data -> da inserire poi

  SleepData.fromJson(String date, Map<String, dynamic> json) :
      // dateOfSleep = ('$date ${json["dateOfSleep"]}'),
      // startTime = ('$date ${json["startTime"]}'),
      // endTime = ('$date ${json["endTime"]}'),
      // duration = int.parse((json["duration"])),
      // minutesToFallAsleep = int.parse(json["minutesToFallAsleep"]),
      // minutesAsleep = int.parse(json["minutesAsleep"]),
      // minutesAwake = int.parse(json["minutesAwake"]),
      // minutesAfterWakeup = int.parse(json["minutesAfterWakeup"]),
      efficiency = int.parse(json["efficiency"]);
      // logType = (json["logType"]).toString(), //capire se è giusto
      // mainSleep = bool ; //come inizializzare
      // levels = ; //come inizializzare
      // data = ; //come inizializzare

      

  // @override
  // String toString() {
  //   return 'Steps(time: $dateOfSleep, startTime: $startTime, )';
  // }//toString
}//SleepData