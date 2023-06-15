import 'package:floor/floor.dart';
// The entity is a summary of the sleeping stages (deep/wake/light/rem/restless) during the sleep session

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['sleepId'],
      parentColumns: ['id'],
      entity: Levels,
    ),
  ],
)
class Levels {

  @PrimaryKey(autoGenerate: true)
  final int id;
  
  final String levelName;
  final int count;
  final int minutes;
  final int thirtyDayAvgMinutes;
  final int sleepId; // chiave esterna sleepId

  Levels(this.id, this.levelName, this.count, this.minutes, this.thirtyDayAvgMinutes, this.sleepId);
}
//Levels