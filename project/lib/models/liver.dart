import 'package:flutter/material.dart';

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