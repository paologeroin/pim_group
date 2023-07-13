import 'package:pim_group/models/entities/goals.dart';
import 'package:floor/floor.dart';

@dao
abstract class GoalDao {
  @Query('SELECT * FROM Goal')
  Future<List<Goal>> findAllGoals();

  @Query('SELECT * FROM Goal ORDER BY dateTime ASC')
  Future<List<Goal>> findMostRecentGoal();

  @insert
  Future<void> insertGoal(Goal goal);

  @delete
  Future<void> deleteGoal(Goal task);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateGoal(Goal goal);
}//GoalDao