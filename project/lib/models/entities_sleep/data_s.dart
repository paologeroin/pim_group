import 'package:floor/floor.dart';
// The entity is the  stage profile of the sleep session.
// Each entry contains the starting timestamp, the level, and how much it lasted
// "dateTime": "02-13 22:44:30", 
// "level": "light",
// "seconds": 150

@entity
class Data {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final DateTime dateTime;
  
  final int level; 

  final int seconds;
  

  Data(this.id, this.dateTime, this.level, this.seconds);
}//Data