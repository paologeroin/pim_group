import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:pim_group/models/drink.dart';

//This class extends ChangeNotifier.
//It will act as data repository for the meals and will be shared thorugh the application.
class DrinksDB extends ChangeNotifier {
  //The MealDB can be represented here as list of meals.
  List<Drink> drinks = [];

  //Method to use to add a drink.
  void addDrink(Drink toAdd) {
    drinks.add(toAdd);
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  } //addProduct

  //Method to use to edit a Drink.
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
} //MealDB
=======

//This class extends ChangeNotifier. It will act as data repository to be shared through the application.
class Liver extends ChangeNotifier {
  //For simplicity, a Drink is just a String (Like the professor done in the lesson)
  List<String> Drinks_drunk = [];

  void addDrinkToLiver(String toAdd) {
    Drinks_drunk.add(toAdd);
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  } //addDrink (that the user drinks)

  void clearLiver() {
    Drinks_drunk.clear();
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  } //ClearLiver (when a User want to restart his travel to the sobriety)
}//Liver
>>>>>>> a406489c4d1833684b9279cf332a9f85e7abb602
