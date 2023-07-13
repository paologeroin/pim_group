import 'package:floor/floor.dart';

@entity
class Sleep {
  @PrimaryKey(autoGenerate: true)
  late int? id;
  late String? date;
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
  late String? levels;
  bool DailyData = true;

  Sleep({
    this.id,
    required this.date,
    required this.dateOfSleep,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.minutesToFallAsleep,
    required this.minutesAsleep,
    required this.minutesAwake,
    required this.minutesAfterWakeup,
    required this.efficiency,
    required this.logType,
    required this.mainSleep,
    this.levels,
  });
}//Sleep