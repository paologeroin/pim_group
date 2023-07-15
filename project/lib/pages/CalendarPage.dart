import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:pim_group/models/repo/app_repository.dart';
import 'package:pim_group/models/entities/drink.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

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
      backgroundColor: Colors.white, // CAMBIO COLORE PAOLO Colors.teal[50],
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 194, 138, 243),
        elevation: 1,
        title: const Text('Calendar'),
        centerTitle: true,
      ),
      body: Column(
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
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
          ),
          SizedBox(
            height: 270,
            child: Center(
              child:
                  //We will show the todo table with a ListView.
                  //To do so, we use a Consumer of DatabaseRepository in order to rebuild the widget tree when
                  //entries are deleted or created.
                  Consumer<AppDatabaseRepository>(
                      builder: (context, dbr, child) {
                //The logic is to query the DB for the entire list of Todo using dbr.findAllTodos()
                //and then populate the ListView accordingly.
                //We need to use a FutureBuilder since the result of dbr.findAllTodos() is a Future.
                return FutureBuilder(
                  initialData: null,
                  future: dbr.findDrinksOnDate(
                      DateTime(_selectedDate.year, _selectedDate.month,
                          _selectedDate.day, 0, 0),
                      DateTime(_selectedDate.year, _selectedDate.month,
                          _selectedDate.day, 23, 59)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as List<Drink>;
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, drinkIndex) {
                            final drink = data[drinkIndex];
                            return Card(
                              elevation: 5,
                              //Here we use a Dismissible widget to create a nicer UI.
                              child: Dismissible(
                                //Just create a dummy unique key
                                key: UniqueKey(),
                                //This is the background to show when the ListTile is swiped
                                background: Container(color: Colors.red),
                                //The ListTile is used to show the Todo entry
                                child: ListTile(
                                  leading: Icon(MdiIcons.note),
                                  title: Text(drink.drinkType),
                                  subtitle: Text('ID: ${drink.id}'),
                                  //If the ListTile is tapped, it is deleted
                                ),
                                //This method is called when the ListTile is dismissed
                                onDismissed: (direction) async {
                                  //No need to use a Consumer, we are just using a method of the DatabaseRepository
                                  await Provider.of<AppDatabaseRepository>(
                                          context,
                                          listen: false)
                                      .removeDrink(drink);
                                },
                              ),
                            );
                          });
                    } else {
                      //A CircularProgressIndicator is shown while the list of Todo is loading.
                      return CircularProgressIndicator();
                    } //else
                  }, //builder of FutureBuilder
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
