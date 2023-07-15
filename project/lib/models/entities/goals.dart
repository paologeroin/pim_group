import 'package:floor/floor.dart';

@entity
class Goal {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final double money;

  Goal({this.id, required this.name, required this.money});
} //Goal
