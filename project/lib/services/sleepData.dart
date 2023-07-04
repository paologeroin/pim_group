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

  SleepData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['data'] != null && json['data'].runtimeType != List) {
      dateOfSleep = json['data']["dateOfSleep"];
      startTime = json['data']["startTime"];
      endTime = json['data']["endTime"];
      duration = json['data']['duration'].toDouble() / 1000;
      minutesToFallAsleep = json['data']["minutesToFallAsleep"];
      minutesAsleep = json['data']['minutesAsleep'];
      minutesAwake = json['data']['minutesAwake'];
      minutesAfterWakeup = json['data']["minutesAfterWakeup"];
      efficiency = json['data']["efficiency"];
      logType = json['data']["logType"].toString();
      mainSleep = json['data']["mainSleep"];
      levels = json['data']["levels"];
      // levelsSummary = json['data']["levels"]['summary'];
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
    }
  }
} //SleepData


