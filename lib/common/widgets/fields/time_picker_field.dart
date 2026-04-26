import 'package:flutter/material.dart';

import '../../helpers/extensions.dart';
import 'app_text_field.dart';

class TimePickerField extends StatefulWidget {
  final Function(TimeOfDay timeOfDay) onTimeChanged;
  final String? labelText;
  final TimeOfDay? initialTime;

  const TimePickerField({
    super.key,
    required this.onTimeChanged,
    this.labelText = 'Select time',
    this.initialTime,
  });

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  TimeOfDay? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialTime;
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selected ?? const TimeOfDay(hour: 8, minute: 0),
    );
    if (picked != null) {
      setState(() => _selected = picked);
      widget.onTimeChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: widget.labelText,
      hintText: _selected?.formatTimeOfDay,
      onTap: () {
        _selectTime(context);
      },
    );
  }
}
