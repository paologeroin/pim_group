import 'package:floor/floor.dart';
// The entity is the estimated sleep efficiency (a int from 0 to 100)
@entity
class Efficiency {

  @PrimaryKey(autoGenerate: true)
  final int? id;
  
  final int efficiency; 
  final DateTime timestamp;

  Efficiency(this.id, this.efficiency, this.timestamp);
}//Efficiency