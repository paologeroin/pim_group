import 'package:floor/floor.dart';
import 'package:pim_group/models/entities_sleep/data_s.dart';

@dao
abstract class DataDao {
  @Query(
      'SELECT * FROM Data WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Data>> findDatabyDate(
      DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the Data table
  @Query('SELECT * FROM Data')
  Future<List<Data>> findAllData();

  //Query #2: INSERT -> this allows to add a Data in the table
  @insert
  Future<void> insertData(Data data);

  //Query #3: DELETE -> this allows to delete a Data from the table
  @delete
  Future<void> deleteData(Data data);

  //Query #4: UPDATE -> this allows to update a Data entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateData(Data data);

  @Query('SELECT * FROM Data ORDER BY dateTime ASC LIMIT 1')
  Future<Data?> findFirstDayInDb(); // si mette il nullable ('?') perché può essere che il database sia vuoto 

  @Query('SELECT * FROM Data ORDER BY dateTime DESC LIMIT 1')
  Future<Data?> findLastDayInDb();
}