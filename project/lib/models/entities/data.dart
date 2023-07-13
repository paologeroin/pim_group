import 'package:floor/floor.dart';
import 'package:pim_group/models/entities/levels.dart';
// The entity is the stage profile of the sleep session.
// Each entry contains the starting timestamp, the level, and how much it lasted
// "dateTime": "02-13 22:44:30",
// "level": "light",
// "seconds": 150

@Entity(
  tableName: 'SleepPhasesData',
  foreignKeys: [
    ForeignKey(
      childColumns: ['level'],
      parentColumns: ['id'],
      entity: Levels,
    ),
  ],
)
class Data {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String dateTime;
  final int seconds;

  @ColumnInfo(name: 'level')
  final String level;

  Data(this.id, this.dateTime, this.seconds, this.level);
} //Data
