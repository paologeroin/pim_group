import 'package:floor/floor.dart';
import 'package:pim_group/models/entities/entities.dart';

@dao
abstract class SleepDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the Sleep table of a certain date
  @Query(
      'SELECT * FROM Sleep WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Sleep>> findSleepbyDate(DateTime startTime, DateTime endTime);

  @Query('SELECT * FROM Sleep')
  Future<List<Sleep>> findAllSleep();

  @insert
  Future<void> insertSleep(Sleep sleep);

  @delete
  Future<void> deleteSleep(Sleep task);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSleep(Sleep sleep);

  @Query('SELECT * FROM Sleep ORDER BY dateTime ASC LIMIT 1')
  Future<Sleep?> findFirstDayInDb();

  @Query('SELECT * FROM Sleep ORDER BY dateTime DESC LIMIT 1')
  Future<Sleep?> findLastDayInDb();
} //SleepDao
