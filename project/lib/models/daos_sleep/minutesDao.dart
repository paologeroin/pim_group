import 'package:floor/floor.dart';
import 'package:pim_group/models/entities_sleep/entities_sleep.dart';

//Here, we are saying that the following class defines a dao.
@dao
abstract class MinutesDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the Minutes table of a certain date
  @Query(
      'SELECT * FROM Exposure WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Minutes>> findMinutesbyDate(
      DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the Minutes table
  @Query('SELECT * FROM Exposure')
  Future<List<Minutes>> findAllMinutes();

  //Query #2: INSERT -> this allows to add a Minutes in the table
  @insert
  Future<void> insertMinutes(Minutes minutes);

  //Query #3: DELETE -> this allows to delete a Minutes from the table
  @delete
  Future<void> deleteMinutes(Minutes minutes);

  //Query #4: UPDATE -> this allows to update a Minutes entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateMinutes(Minutes minutes);

  @Query('SELECT * FROM Exposure ORDER BY dateTime ASC LIMIT 1')
  Future<Minutes?> findFirstDayInDb(); // si mette il nullable ('?') perché può essere che il database sia vuoto 

  @Query('SELECT * FROM Exposure ORDER BY dateTime DESC LIMIT 1')
  Future<Minutes?> findLastDayInDb();
}//MinutesDao