import 'package:floor/floor.dart';
import 'package:pim_group/models/entities/entities.dart';

@dao
abstract class DataDao {
  @Query(
      'SELECT * FROM Data WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Data>> findDatabyDate(DateTime startTime, DateTime endTime);

  @Query('SELECT * FROM Data')
  Future<List<Data>> findAllData();

  @Query('SELECT * FROM Data WHERE id = :id')
  Future<Data?> getDataById(int id);

  @Query('SELECT * FROM Level WHERE sleepId = :sleepId')
  Future<List<Data>> getDataForSleep(int sleepId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertData(Data data);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateData(Data data);

  @delete
  Future<void> deleteData(Data data);
}//DataDao