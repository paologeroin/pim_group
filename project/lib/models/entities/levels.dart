import 'package:floor/floor.dart';
import 'package:pim_group/models/entities/entities.dart';

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

  @ColumnInfo(name: 'phase')
  final String phase;

  Levels(this.id, this.count, this.minutes, this.phase);
}
//Levels