//This is the data model of a goal.
class Goal {
  // The Goal has a name and a budget to reach with the money risparmiati
  String name;

  double money;

  // We can also save the date in which the user create the goal
  // the goal that is created first has the priority respect to the others
  // I think it was the best idea to manage with less problems this page
  DateTime dateTime;

  //Constructor
  Goal(
      {required this.name,
      required this.money,
      required this.dateTime}); // INSERISCI QUANDO CAPISCI IL METODO
} //Goal
