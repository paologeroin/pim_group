import 'package:flutter/material.dart';
import 'package:pim_group/models/goal.dart';

//This class extends ChangeNotifier.
//It will act as data repository for the meals and will be shared thorugh the application.
class GoalDB extends ChangeNotifier {
  //The GoalDB can be represented here as list of goals.
  List<Goal> goals = [];

  //Method to use to add a goal.
  void addGoal(Goal toAdd) {
    goals.add(toAdd);
    //Call the notifyListeners() method to alert that someone has inserted a new goal
    notifyListeners();
  } //addGoal

  //Method to use to edit a Goal.
  void editGoal(int index, Goal newGoal) {
    goals[index] = newGoal;
    //Call the notifyListeners() method to alert that someone has modified a goal.
    notifyListeners();
  } //editGoal

  //Method to use to delete a goal.
  void deleteGoal(int index) {
    goals.removeAt(index);
    //Call the notifyListeners() method to alert that someone has deleted a goal.
    notifyListeners();
  } //deleteGoal
} //goal
