import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:pim_group/models/repo/app_repository.dart';
import 'package:pim_group/models/entities/drink.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressState();
}

class _ProgressState extends State<ProgressPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 194, 138, 243),
        elevation: 1,
        title: const Text('Calendar'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TableCalendar(
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDate, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDate = selectedDay;
                        _focusedDay = focusedDay; 
                      });
                    },
                  ),
                  Consumer<AppDatabaseRepository>(
                    builder: (context, dbr, child) {
                      return FutureBuilder(
                        initialData: null,
                        future: dbr.findDrinksOnDate(
                          DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            _selectedDate.day,
                            0,
                            0,
                          ),
                          DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            _selectedDate.day,
                            23,
                            59,
                          ),
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data as List<Drink>;
                            return Column(
                              children: data.map((drink) {
                                return Card(
                                  elevation: 5,
                                  child: Dismissible(
                                    key: UniqueKey(),
                                    background: Container(color: Colors.red),
                                    child: ListTile(
                                      leading: Icon(MdiIcons.note),
                                      title: Text(drink.drinkType),
                                      subtitle: Text('Drink Number: ${drink.id}'),
                                    ),
                                    onDismissed: (direction) async {
                                      await Provider.of<AppDatabaseRepository>(
                                        context,
                                        listen: false,
                                      ).removeDrink(drink);
                                    },
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
