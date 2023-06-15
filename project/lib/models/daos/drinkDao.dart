import 'package:pim_group/models/entities/drink.dart';
import 'package:floor/floor.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class DrinkDao {

  //Query #1: SELECT -> this allows to obtain all the entries of the Drink table
  @Query('SELECT * FROM Drink')
  Future<List<Drink>> findAllDrinks();

  //Query #1: SELECT -> this allows to obtain all the entries of the Drink table in a specific date
  @Query('SELECT * FROM Drink WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Drink>> findDrinksOnDate(DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the Drink table
  @Query('SELECT * FROM Drink ORDER BY dateTime ASC')
  Future<List<Drink>> findMostRecentDrink();

  //Query #2: INSERT -> this allows to add a Todo in the table
  @insert
  Future<void> insertDrink(Drink drink);

  //Query #3: DELETE -> this allows to delete a Todo from the table
  @delete
  Future<void> deleteDrink(Drink task);

}//DrinkDao