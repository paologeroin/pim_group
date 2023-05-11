import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressState();
}

class _ProgressState extends State<ProgressPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, // CAMBIO COLORE PAOLO Colors.teal[50],
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 109, 230, 69),
          elevation: 1,
          title: const Text('Calendar'),
          centerTitle: true,
        ),
        body: TableCalendar(
          calendarFormat: _calendarFormat,
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
        ));
  }
}
