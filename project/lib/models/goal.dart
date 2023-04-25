//This is the data model of a meal.
class Goal {
  // The Goal has a name and a budget to reach with the money saved

  // String name; INSERISCI QUANDO CAPISCI IL METODO

  double money;

  // We can also save the date in which the user create the goal
  // the goal that is created first has the priority respect to the others
  // I think it was the best idea to manage with less problems this page
  DateTime dateTime;

  //Constructor
  // Goal({required this.name, required this.money, required this.dateTime}); // INSERISCI QUANDO CAPISCI IL METODO
  Goal({required this.money, required this.dateTime});
} //Goal
