import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: SingleChildScrollView(
        child: SafeArea(
          child: TableCalendar(
            daysOfWeekHeight: 60,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
              weekendStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonTextStyle: TextStyle(
                fontFamily: "Tangerine",
                fontSize: 25,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
            calendarStyle: CalendarStyle(
              defaultTextStyle: TextStyle(fontSize: 30),
              weekendTextStyle: TextStyle(fontSize: 30),
            ),
            firstDay: DateTime.utc(2024, 01, 01),
            lastDay: DateTime.utc(2040, 01, 01),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            calendarFormat: _calendarFormat,
            onFormatChanged: _onFormatChanged,
          ),
        ),
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(selectedDay, _selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  void _onFormatChanged(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
    });
  }
}
