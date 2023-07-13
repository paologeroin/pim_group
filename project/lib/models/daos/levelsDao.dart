import 'package:floor/floor.dart';
import 'package:pim_group/models/entities/entities.dart';

@dao
abstract class LevelsDao {
  @Query(
      'SELECT * FROM Levels WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Levels>> findLevelsbyDate(DateTime startTime, DateTime endTime);

  @Query('SELECT * FROM Levels')
  Future<List<Levels>> findAllLevels();

  @Query('SELECT * FROM Level WHERE id = :id')
  Future<Levels?> getLevelsById(int id);

  @Query('SELECT * FROM Level WHERE phase = :phase')
  Future<List<Levels>> getLevelsForSleep(int phase);

  @Query(
      'SELECT count FROM Levels WHERE levelName = "awake" AND phase = :phase')
  Future<int?> getAwakeCount(int phase);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertLevels(Levels levels);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateLevels(Levels levels);

  @delete
  Future<void> deleteLevels(Levels levels);
}//LevelsDao