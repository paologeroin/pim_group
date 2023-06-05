import 'package:floor/floor.dart';
// The entity is the stage profile of the sleep session.
// Each entry contains the starting timestamp, the level, and how much it lasted
// "dateTime": "02-13 22:44:30", 
// "level": "light",
// "seconds": 150

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['sleepId'],
      parentColumns: ['id'],
      entity: Data,
    ),
  ],
)
class Data {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final DateTime dateTime;
  final int level; 
  final int seconds;

  final int sleepId; // chiave esterna sleepId

  Data(this.id, this.dateTime, this.level, this.seconds, this.sleepId);
}//Data