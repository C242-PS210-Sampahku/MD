import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  // Dummy reminder data (Map of DateTime and List of String)
  final Map<DateTime, List<String>> reminders;

  CalendarScreen({required this.reminders, super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Map<DateTime, List<String>> _reminders;
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  List<String> _getRemindersForDay(DateTime day) {
    // Normalize the date to remove the time component and compare only by date
    DateTime normalizedDay = DateTime(day.year, day.month, day.day);
    print('Checking reminders for $normalizedDay'); // Debugging log
    // Return the reminders for this normalized day, or an empty list if no reminders exist
    return _reminders[normalizedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    _reminders = widget.reminders;
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminder"),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) {
              // Log data to check if eventLoader is working correctly
              print(day);
              return _getRemindersForDay(day);
            },
          ),
          const SizedBox(height: 20),
          // Display reminders for selected day
          if (_getRemindersForDay(_selectedDay).isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reminder Buang Sampah.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ..._getRemindersForDay(_selectedDay).map((reminder) {
                    return ListTile(
                      title: Text(reminder),
                    );
                  }).toList(),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Tidak ada reminder dihari ini."),
            ),
        ],
      ),
    );
  }
}
