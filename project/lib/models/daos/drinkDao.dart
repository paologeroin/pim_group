import 'package:pim_group/models/entities/drink.dart';
import 'package:floor/floor.dart';

@dao
abstract class DrinkDao {
  @Query('SELECT * FROM Drink')
  Future<List<Drink>> findAllDrinks();

  @Query(
      'SELECT * FROM Drink WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Drink>> findDrinksOnDate(DateTime startTime, DateTime endTime);

  @Query('SELECT * FROM Drink ORDER BY dateTime ASC')
  Future<List<Drink>> findMostRecentDrink();

  @insert
  Future<void> insertDrink(Drink drink);

  @delete
  Future<void> deleteDrink(Drink drink);
}//DrinkDao