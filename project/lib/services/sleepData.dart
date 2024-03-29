import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/server_strings.dart';
import 'impact.dart';

class SleepData {
  late String date;
  late String? dateOfSleep;
  late String? startTime;
  late String? endTime;
  late double? duration;
  late int? minutesToFallAsleep;
  late int? minutesAsleep;
  late int? minutesAwake;
  late int? minutesAfterWakeup;
  late int? efficiency;
  late String? logType;
  late bool? mainSleep;
  late Map? levels;
  bool DailyData = true;

  

  SleepData.fromJson(Map<String, dynamic> json) {
    date = json['date'].toString();
    if (json['data'].isNotEmpty) {
      dateOfSleep = json['data'][0]['dateOfSleep'].toString();
      startTime = json['data'][0]["startTime"].toString();
      endTime = json['data'][0]["endTime"].toString();
      duration = json['data'][0]['duration'].toDouble() / 1000;
      minutesToFallAsleep = json['data'][0]["minutesToFallAsleep"];
      minutesAsleep = json['data'][0]['minutesAsleep'];
      minutesAwake = json['data'][0]['minutesAwake'];
      minutesAfterWakeup = json['data'][0]["minutesAfterWakeup"];
      efficiency = json['data'][0]["efficiency"];
      logType = json['data'][0]["logType"].toString();
      mainSleep = json['data'][0]["mainSleep"];
      levels = json['data'][0]["levels"];

      /*
      for (String phase in phaseName) {
        SleepPhasesData sleepPhase = SleepPhasesData(
          dateTime: json['data']['levels']['data'][phase]['dateTime'],
          seconds: json['data']['levels']['data'][phase]['seconds'],
        );
        phases[phase] = sleepPhase;
      }

      for (String level in levelName) {
        LevelSummaryData sleepLevel = LevelSummaryData(
          count: json['data']['levels']['summary'][level]['count'],
          minutes: json['data']['levels']['summary'][level]['minutes'],
        );
        levelsData[level] = sleepLevel;
      }

      if (duration == null) {
        DailyData = false;
      }*/
    } else {
      dateOfSleep = null;
      startTime = null;
      endTime = null;
      duration = null;
      minutesToFallAsleep = null;
      minutesAsleep = null;
      minutesAwake = null;
      minutesAfterWakeup = null;
      efficiency = null;
      logType = null;
      mainSleep = null;
      levels = null;
      DailyData = false;
     
    }
  }
} //SleepData

