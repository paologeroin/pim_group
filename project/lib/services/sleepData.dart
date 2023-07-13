//troveremo un modo per definire sto file
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
  // late Map? levelsSummary;
  bool DailyData = true;

  Map<String, LevelSummaryData> levelsData = {};
  List<String> levelName = ['wake', 'light', 'deep', 'rem'];

  Map<String, SleepPhasesData> phases ={};
  List<String> phaseName = ['wake', 'light', 'deep', 'rem'];

  SleepData.fromJson(Map<String, dynamic> json) {
    date = json['date'].toString();
    if (!(json['data'] == null)) {
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

      for (String phase in phaseName) {
        SleepPhasesData sleepPhase = SleepPhasesData(
          dateTime : json['data']['levels']['data'][phase]['dateTime'],
          seconds : json['data']['levels']['data'][phase]['seconds'],
        );
        phases[phase] = sleepPhase;
      }

      for (String level in levelName) {
        LevelSummaryData sleepLevel = LevelSummaryData(
          count : json['data']['levels']['summary'][level]['count'],
          minutes : json['data']['levels']['summary'][level]['minutes'],
        );
        levelsData[level] = sleepLevel;
      }

      if (duration == null) {
        DailyData = false;
      }
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
      for (String level in levelName) {
        LevelSummaryData sleepLevel = LevelSummaryData(count: null, minutes : null);
        levelsData[level] = sleepLevel;
      }
      for (String phase in phaseName) {
        SleepPhasesData sleepPhase = SleepPhasesData(dateTime: null, seconds : null);
        phases[phase] = sleepPhase;
      }
    }
  }
} //SleepData

// I create a new class for LevelSummaryData to access sleep stage data. We are mainly interested in the "count" and "minutes"
class LevelSummaryData {
  late int? count;
  late int? minutes;

  LevelSummaryData({required this.count, required this.minutes});

}//LevelSummaryData

// I create a class for SleepPhasesData to access levels->data in which the duration of each phase is contained, useful for hypnograms
class SleepPhasesData {
  late String? dateTime; 
  late int? seconds;

  SleepPhasesData({required this.dateTime, required this.seconds});

}//SleepPhases