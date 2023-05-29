import 'package:floor/floor.dart';
// The entity is the starting/ending timestamp of the sleep (MM-DD hh:mm:ss format)

@entity
class TimeLimit {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final DateTime startingTime;
  
  final DateTime endingTime;

  final DateTime timestamp;
  

  TimeLimit(this.id, this.startingTime, this.endingTime, this.timestamp);
}//TimeLimit