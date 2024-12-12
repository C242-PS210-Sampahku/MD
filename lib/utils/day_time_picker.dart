import 'package:flutter/material.dart';

Future<String?> showDayPickerDialog(BuildContext context) async {
  List<String> days = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday",
];


  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Pilih Hari"),
        content: SingleChildScrollView(
          child: Column(
            children: days.map((day) {
              return ListTile(
                title: Text(day),
                onTap: () {
                  Navigator.pop(context, day); // Mengembalikan hari yang dipilih
                },
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}


  Future<String> showTimePickerDialog(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      return pickedTime.format(context);
    }else{
      return "";
    }
  }