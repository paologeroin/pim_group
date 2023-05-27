import 'package:floor/floor.dart';
import 'package:pim_group/models/entities_sleep/efficiencies.dart';

@dao
abstract class EfficiencyDao {
  @Query(
      'SELECT * FROM Efficiency WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Efficiency>> findEfficienciesbyDate(
      DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the Efficiency table
  @Query('SELECT * FROM Efficiency')
  Future<List<Efficiency>> findAllEfficiencies();

  //Query #2: INSERT -> this allows to add a Efficiency in the table
  @insert
  Future<void> insertEfficiency(Efficiency efficiencies);

  //Query #3: DELETE -> this allows to delete a Efficiency from the table
  @delete
  Future<void> deleteEfficiency(Efficiency efficiencies);

  //Query #4: UPDATE -> this allows to update a Efficiency entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateEfficiency(Efficiency efficiencies);

  @Query('SELECT * FROM Efficiency ORDER BY dateTime ASC LIMIT 1')
  Future<Efficiency?> findFirstDayInDb(); // si mette il nullable ('?') perché può essere che il database sia vuoto 

  @Query('SELECT * FROM Efficiency ORDER BY dateTime DESC LIMIT 1')
  Future<Efficiency?> findLastDayInDb();
}