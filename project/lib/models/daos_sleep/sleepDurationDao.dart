import 'package:floor/floor.dart';
import 'package:pim_group/models/entities_sleep/entities_sleep.dart';

//Here, we are saying that the following class defines a dao.
@dao
abstract class SleepDurationDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the SleepDuration table of a certain date
  @Query(
      'SELECT * FROM Exposure WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<SleepDuration>> findExposuresbyDate(
      DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the SleepDuration table
  @Query('SELECT * FROM Exposure')
  Future<List<SleepDuration>> findAllSleepDuration();

  //Query #2: INSERT -> this allows to add a SleepDuration in the table
  @insert
  Future<void> insertSleepDuration(SleepDuration sleepDurations);

  //Query #3: DELETE -> this allows to delete a SleepDuration from the table
  @delete
  Future<void> deleteSleepDuration(SleepDuration sleepDurations);

  //Query #4: UPDATE -> this allows to update a Exposure entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSleepDuration(SleepDuration sleepDurations);

  @Query('SELECT * FROM Exposure ORDER BY dateTime ASC LIMIT 1')
  Future<SleepDuration?> findFirstDayInDb(); // si mette il nullable ('?') perché può essere che il database sia vuoto 

  @Query('SELECT * FROM Exposure ORDER BY dateTime DESC LIMIT 1')
  Future<SleepDuration?> findLastDayInDb();
}//SleepDurationDao