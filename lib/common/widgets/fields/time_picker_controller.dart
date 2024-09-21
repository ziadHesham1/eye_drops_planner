import 'package:flutter/material.dart';

class TimePickerController extends ChangeNotifier {
  TimeOfDay _selectedTime;

  TimePickerController(this._selectedTime);

  TimeOfDay get selectedTime => _selectedTime;

  set selectedTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
  }
}
