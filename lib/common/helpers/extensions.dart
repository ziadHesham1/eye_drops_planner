import 'package:bill_planner/common/models/schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  TimeOfDay get toTimeOfDay {
    return TimeOfDay(hour: hour, minute: minute);
  }
  //  DateFormat.yMMMd().format(eyeDrop.startingDate!)

  String get yMMMdFormat {
    return DateFormat.yMMMd().format(this);
  }
}

extension NullableScheduleExtension on ScheduleModel? {
  get isNull => this == null;
  get isNotNull => this != null;
  get isNullOrEmpty => this == null || this! == ScheduleModel.empty();
  get isNotNullOrEmpty => this != null && this! != ScheduleModel.empty();
}

extension NullableList<T> on List<T>? {
  get isNull => this == null;
  get isNotNull => this != null;
  get isNullOrEmpty => this == null || this!.isEmpty;
  get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}

extension NullableTimeOfDayExtension on TimeOfDay? {
  get isNull => this == null;
  get isNotNull => this != null;
}

extension TimeOfDayExtension on TimeOfDay {
  String get to24HourString {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  // 12 hours to string
  String get to12HourString {
    return '${hour > 12 ? hour - 12 : hour}:'
        '${minute.toString().padLeft(2, '0')} ${hour > 12 ? 'PM' : 'AM'}';
  }

  DateTime get toDateTime {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  String get formatTimeOfDay {
    DateTime dt = toDateTime;
    final format = DateFormat.jm();
    return format.format(dt);
  }

  Duration difference(TimeOfDay other) {
    return toDateTime.difference(other.toDateTime);
  }

  TimeOfDay addHours(double number) {
    int hours = number.toInt();
    int minutes = ((number - hours) * 60).toInt();
    return toDateTime.add(Duration(hours: hours, minutes: minutes)).toTimeOfDay;
  }
}
