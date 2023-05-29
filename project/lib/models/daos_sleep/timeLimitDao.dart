import 'package:floor/floor.dart';
import 'package:pim_group/models/entities_sleep/time_limits.dart';

@dao
abstract class TimeLimitDao {
  // capire
  // @Query(
  //     'SELECT * FROM TimeLimit WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  // Future<List<TimeLimit>> findDatabyDate(
  //     DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the TimeLimit table
  @Query('SELECT * FROM TimeLimit')
  Future<List<TimeLimit>> findAllTimeLimit();

  //Query #2: INSERT -> this allows to add a TimeLimit in the table
  @insert
  Future<void> insertTimeLimit(TimeLimit data);

  //Query #3: DELETE -> this allows to delete a TimeLimit from the table
  @delete
  Future<void> deleteTimeLimit(TimeLimit data);

  //Query #4: UPDATE -> this allows to update a TimeLimit entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateTimeLimit(TimeLimit timeLimit);
  
  // capire: non ho dateTime come variabile
  @Query('SELECT * FROM TimeLimit ORDER BY dateTime ASC LIMIT 1')
  Future<TimeLimit?> findFirstDayInDb(); // si mette il nullable ('?') perché può essere che il database sia vuoto 

  @Query('SELECT * FROM TimeLimit ORDER BY dateTime DESC LIMIT 1')
  Future<TimeLimit?> findLastDayInDb();
}//TimeLimitDao