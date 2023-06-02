import 'package:floor/floor.dart';
// The entity is a summary of the sleeping stages (deep/wake/light/rem/restless) during the sleep session

// Ha senso??????
@Entity(
  tableName: 'levels', 
  /*foreignKeys: [
    ForeignKey(
      childColumns: ['count', 'minutes', 'thirtyDayAvgMinutes'],
      parentColumns: ['deep', 'light', 'rem', 'awake'],
      entity: Levels,
      )
  ],*/
)
class Levels {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String deep;
  
  final String light;

  final String rem;

  final String awake;
  

  Levels(this.id, this.deep, this.light, this.rem, this.awake);
}//Levels