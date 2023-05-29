import 'package:floor/floor.dart';
import 'package:pim_group/models/entities_sleep/entities_sleep.dart';

//Here, we are saying that the following class defines a dao.
@dao
abstract class LevelsDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the Levels table of a certain date
  @Query(
      'SELECT * FROM Levels WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Levels>> findLevelsbyDate(
      DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the Levels table
  @Query('SELECT * FROM Levels')
  Future<List<Levels>> findAllLevels();

  //Query #2: INSERT -> this allows to add a Levels in the table
  @insert
  Future<void> insertLevels(Levels levels);

  //Query #3: DELETE -> this allows to delete a Levels from the table
  @delete
  Future<void> deleteLevels(Levels levels);

  //Query #4: UPDATE -> this allows to update a Levels entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateLevels(Levels levels);

  @Query('SELECT * FROM Levels ORDER BY dateTime ASC LIMIT 1')
  Future<Levels?> findFirstDayInDb(); // si mette il nullable ('?') perché può essere che il database sia vuoto 

  @Query('SELECT * FROM Levels ORDER BY dateTime DESC LIMIT 1')
  Future<Levels?> findLastDayInDb();
}//LevelsDao