import 'package:flutter/material.dart';

class TimePicker {
  TimePicker._();

  static getDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: const Locale("ko"),
      helpText: null,
    );
  }

  static getHour(BuildContext context) {
    showTimePicker(
        hourLabelText: null,
        minuteLabelText: null,
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input);
  }
}
