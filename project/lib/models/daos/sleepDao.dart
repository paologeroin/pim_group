import 'package:floor/floor.dart';
import 'package:pim_group/models/entities/entities.dart';

//Here, we are saying that the following class defines a dao.
@dao
abstract class SleepDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the Sleep table of a certain date
  @Query(
      'SELECT * FROM Sleep WHERE date = :date')
  Future<List<Sleep>> findSleepbyDate(String date);

  //Query #1: SELECT -> this allows to obtain all the entries of the Sleep table
  @Query('SELECT * FROM Sleep')
  Future<List<Sleep>> findAllSleep();

  //Query #2: INSERT -> this allows to add a Sleep in the table
  @insert
  Future<void> insertSleep(Sleep sleep);

  //Query #3: DELETE -> this allows to delete a Sleep from the table
  @delete
  Future<void> deleteSleep(Sleep task);

  //Query #4: UPDATE -> this allows to update a Sleep entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSleep(Sleep sleep);

  @Query('SELECT * FROM Sleep ORDER BY dateTime ASC LIMIT 1')
  Future<Sleep?> findFirstDayInDb(); // si mette il nullable ('?') perché può essere che il database sia vuoto

  @Query('SELECT * FROM Sleep ORDER BY dateTime DESC LIMIT 1')
  Future<Sleep?> findLastDayInDb();
    
} //SleepDao
