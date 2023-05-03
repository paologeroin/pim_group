//This is the data model of a drink.
class Drink {
  //The carbohydrates content of the meal
  List<String> drinks = [
    'Beer',
    'Gin Tonic',
    'Spritz'
  ]; // DA MODIFICARE, VOGLIAMO SCEGLIERE DRINK DALLA LISTA
  //When the meal occured
  DateTime dateTime;

  //Constructor
  // FORSE è DA TOGLIERE il required per il primo terminer
  Drink({required this.drinks, required this.dateTime});
} //Meal
