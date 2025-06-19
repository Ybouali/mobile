import 'package:advanced_diary_app/features/components/entry_card.dart';
import 'package:advanced_diary_app/features/controllers/entry_controller.dart';
import 'package:advanced_diary_app/features/models/entry_model.dart';
import 'package:advanced_diary_app/utils/entry_poup_help.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final EntryController entryController = Get.put(EntryController());
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              TableCalendar(
                daysOfWeekHeight: 60,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                  ),
                  weekendStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                  titleTextStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(fontSize: 18),
                  weekendTextStyle: TextStyle(fontSize: 18),
                ),
                firstDay: DateTime.utc(2024, 01, 01),
                lastDay: DateTime.utc(2040, 01, 01),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: _onDaySelected,
                calendarFormat: _calendarFormat,
                onFormatChanged: _onFormatChanged,
              ),
              Obx(() {
                if (entryController.entryListByTime.isEmpty) {
                  return Center(
                    child: Text(
                      "No Entry For this day",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: entryController.entryListByTime.length,
                  itemBuilder: (context, index) {
                    EntryModel entry = entryController.entryListByTime[index];
                    return EntryCard(
                      entry: entry,
                      onTap: () => EntryPoupHelp().showMoreInfoOfFeeling(
                        context,
                        entryController,
                        entry,
                        _selectedDay,
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final EntryController entryController = Get.put(EntryController());
    if (!isSameDay(selectedDay, _selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      entryController.getAllEntrybyEmailAndFixedTime(selectedDay);
    }
  }

  void _onFormatChanged(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
    });
  }
}
