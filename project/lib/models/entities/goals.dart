import 'package:floor/floor.dart';

@entity
class Goal {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final double money;
  DateTime dateTime;

  Goal(
      {this.id,
      required this.name,
      required this.money,
      required this.dateTime});
} //Goal
