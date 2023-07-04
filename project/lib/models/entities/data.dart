import 'package:floor/floor.dart';
import 'package:pim_group/models/entities/levels.dart';
// The entity is the stage profile of the sleep session.
// Each entry contains the starting timestamp, the level, and how much it lasted
// "dateTime": "02-13 22:44:30",
// "level": "light",
// "seconds": 150

@Entity(
  tableName: 'data',
  foreignKeys: [
    ForeignKey(
      childColumns: ['levels_id'],
      parentColumns: ['id'],
      entity: Levels,
    ),
  ],
)
class Data {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final DateTime dateTime;
  final int level;
  final int seconds;

  @ColumnInfo(name: 'levels_id')
  final String levelsId;

  Data(this.id, this.dateTime, this.level, this.seconds, this.levelsId);
} //Data
