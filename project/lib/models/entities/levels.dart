import 'package:floor/floor.dart';
import 'package:pim_group/models/entities/entities.dart';
// The entity is a summary of the sleeping stages (deep/wake/light/rem/restless) during the sleep session

@Entity(
  tableName: 'levels',
  foreignKeys: [
    ForeignKey(
      childColumns: ['sleep_id'],
      parentColumns: ['id'],
      entity: Sleep,
    ),
  ],
)
class Levels {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String data;
  final String summary;

  // chiave esterna sleepId
  @ColumnInfo(name: 'sleep_id')
  final String sleepId;

  Levels(this.id, this.data, this.summary, this.sleepId);
}
//Levels