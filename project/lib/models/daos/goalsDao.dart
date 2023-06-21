import 'package:pim_group/models/entities/goals.dart';
import 'package:floor/floor.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class GoalDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the Drink table
  @Query('SELECT * FROM Goal')
  Future<List<Goal>> findAllGoals();

  //Query #1: SELECT -> this allows to obtain all the entries of the Goal table
  @Query('SELECT * FROM Goal ORDER BY dateTime ASC')
  Future<List<Goal>> findMostRecentGoal();

  //Query #2: INSERT -> this allows to add a Goal in the table
  @insert
  Future<void> insertGoal(Goal goal);

  //Query #3: DELETE -> this allows to delete a Goal from the table
  @delete
  Future<void> deleteGoal(Goal task);

  //Query #4: UPDATE -> this allows to update a Goal entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateGoal(Goal goal);
}//GoalDao