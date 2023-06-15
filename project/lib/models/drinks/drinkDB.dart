import 'package:flutter/material.dart';
import 'package:pim_group/models/entities/drink.dart';

//This class extends ChangeNotifier.
//It will act as data repository for the drinks and will be shared thorugh the application.
class DrinkDB extends ChangeNotifier {
  //The MealDB can be represented here as list of drinks.
  List<Drink> drinks = [];

  //Method to use to add a drink.
  void addDrink(Drink toAdd) {
    drinks.add(toAdd);
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  } //addProduct

  //Method to use to edit a drink.
  void editDrink(int index, Drink newDrink) {
    drinks[index] = newDrink;
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  } //editDrink

  //Method to use to delete a drink.
  void deleteDrink(int index) {
    drinks.removeAt(index);
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  } //deleteDrink
} //DrinkDB
