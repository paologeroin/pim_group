import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:pim_group/models/sleep/sleep_provider.dart';

// Refer to lab_04-hello_flutter for list of fitbit sleep data
// dateOfSleep: day associated to the sleep entry (MM-DD format)
class DateOfSleep {
  final DateTime dateOfSleep; //penso sia DateTime

  DateOfSleep(this.dateOfSleep); //dà errore se metto required
} //DateOfSleep

// startTime: the starting timestamp of the sleep (MM-DD hh:mm:ss format)
class StartTime {
  final DateTime startTime;
  final DateTime timestamp;

  StartTime(this.startTime, this.timestamp);
} //StartTime

// endTime: the ending timestamp of the sleep (MM-DD hh:mm:ss format)
class EndTime {
  final DateTime endTime;
  final DateTime timestamp;

  EndTime(this.endTime, this.timestamp);
}

// duration: the duration of the sleep session (in ms)
class sleepDuration {
  final int durationValue;
  final DateTime timestamp;

  sleepDuration(this.durationValue, this.timestamp);
} //Duration

// minutesAsleep: the number of minutes asleep during the sleep entry
class MinutesAsleep {
  final int minutesAsleep;
  final DateTime timestamp;

  MinutesAsleep(this.minutesAsleep, this.timestamp); //dà errore se metto required
} //MinutesAsleep

// minutesAwake: the number of minutes awake during the sleep entry
class MinutesAwake {
  final int minutesAwake;
  final DateTime timestamp;

  MinutesAwake(this.minutesAwake, this.timestamp); //dà errore se metto required
} //MinutesAwake

// efficiency: the estimated sleep efficiency (from 0 to 100)
class Efficiency {
  final int efficiency; 
  final DateTime timestamp;

  Efficiency(this.efficiency, this.timestamp); //dà errore se metto required
}//Efficiency

// levels: a summary of the sleeping stages (deep/wake/light/rem/restless)
// during the sleep session

// data: the stage profile of the sleep session. Each entry contains the
// starting timestamp, the level, and how much it lasted.


class FitbitGen {
  final Random _random = Random();

  // List<sleepDuration> fetchSleepDuration() {
  //   return List.generate(
  //       100,
  //       (index) => sleepDuration(
  //         durationValue: _random.nextInt(180),
  //         timestamp: DateTime.now().subtract(Duration(hours: index))
  //       )
  //   );
  // }
}