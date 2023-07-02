import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pim_group/models/entities/entities.dart';
import 'package:pim_group/models/db_sleep.dart';
import 'package:pim_group/services/impact.dart';
import 'package:pim_group/utils/server_strings.dart';
import 'package:intl/intl.dart';
import '../daos/daos.dart';


// this is the change notifier. it will manage all the logic of the home page:
// fetching the correct data from the database and on
// startup fetching the data from the online services
class SleepProvider extends ChangeNotifier{
  // Data to be used by the UI

  late List<Sleep> sleep;
  late List<Levels> level;
  late List<Data> data;
  final AppDatabase sleepDB;
  late int? awakeCount;

  // There will be a privite part that is used only by the sleep_provider
  // data fetched from external services or db
  late List<Sleep> _sleep;
  late List<Levels> _level;
  late List<Data> _data;

  // selected day of data to be shown
  DateTime dateOfSleep = DateTime.now().subtract(const Duration(days: 1));
  late DateTime lastFetch;
  final ImpactService impactService;
  bool doneInit = false;

  SleepProvider(this.impactService, this.sleepDB) {
    _init();
  }
  
  Future<void> _init() async {
    
  }//_init


} //SleepProvider