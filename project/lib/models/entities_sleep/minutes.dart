import 'package:floor/floor.dart';

//Here, we are saying to floor that this is a class that defines an entity
// The entity is the the number of minutes asleep or awake during the sleep entry
@entity
class Minutes {
  //Da tutor: id will be the primary key of the table. Moreover, it will be autogenerated.
  //id is nullable since it is autogenerated.
  @PrimaryKey(autoGenerate: true)
  final int? id;

  // minutes asleep during the sleep entry
  final int minutesAsleep;

  // minutes awake during the sleep entry
  final int minutesAwake;


  // Default constructor
  Minutes(this.id, this.minutesAsleep, this.minutesAwake);
}//Minutes