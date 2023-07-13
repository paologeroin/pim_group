import 'package:floor/floor.dart';
import 'package:pim_group/models/entities/entities.dart';
// The entity is a summary of the sleeping stages (deep/wake/light/rem/restless) during the sleep session

@Entity(
  tableName: 'levelSummary',
  foreignKeys: [
    ForeignKey(
      childColumns: ['phase'],
      parentColumns: ['id'],
      entity: Sleep,
    ),
  ],
)
class Levels {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int count;
  final int minutes;

  // chiave esterna sleepId
  @ColumnInfo(name: 'phase')
  final String phase;

  Levels(this.id, this.count, this.minutes, this.phase);
}
//Levels