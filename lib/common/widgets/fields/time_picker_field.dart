import 'package:flutter/material.dart';

import 'app_text_field.dart';

class TimePickerField extends StatefulWidget {
  final Function(TimeOfDay timeOfDay) onTimeChanged;
  final String? labelText;

  const TimePickerField({
    super.key,
    required this.onTimeChanged,
    this.labelText = 'Select time',
  });

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
    );
    if (picked != null) {
      widget.onTimeChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: widget.labelText,
      onTap: () {
        _selectTime(context);
      },
    );
  }
}
