import 'package:floor/floor.dart';

@entity
class Drink {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String drinkType;

  DateTime dateTime;

  Drink({this.id, required this.drinkType, required this.dateTime});
}//Drink
