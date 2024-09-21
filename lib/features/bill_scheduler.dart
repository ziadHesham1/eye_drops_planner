import 'package:flutter/material.dart';

import '../common/helpers/extensions.dart';

class BillScheduler {
  final int numberOfDrops;
  final TimeOfDay startingTime;
  final TimeOfDay endingTime;

  final double minInterval;

  BillScheduler({
    required this.numberOfDrops,
    required this.startingTime,
    required this.endingTime,
    this.minInterval = 0.5,
  });

  List<TimeOfDay> generateTimingList() {
    var hoursNumber = endingTime.difference(startingTime).inHours;
    double interval = (hoursNumber / numberOfDrops);
//
    // interval = adjustInterval(interval);
    List<TimeOfDay> list = [];
    for (int i = 0; i < numberOfDrops; i++) {
      var time = startingTime.addHours(i * interval);
      list.add(time);
    }
    return list;
  }

  double adjustInterval(double interval) {
    // Check if the interval is less than the minimum allowed interval (0.5 hours).
    if (interval < minInterval) {
      // If true, return the minimum interval (0.5 hours).
      return minInterval;
    }
    // Check if the interval is less than 1 hour but greater than or equal to the minimum interval.
    else if (interval < 1) {
      // If the interval is 0.8 hours or more, round it up to 1.0 hour.
      // Otherwise, set the interval to the minimum interval (0.5 hours).
      return (interval >= 0.8) ? 1.0 : minInterval;
    }
    // If the interval is 1 hour or more, floor it to the nearest whole number.
    return interval.floorToDouble();
  }

  TimeOfDay doubleToTime(double number) {
    int hour = number.toInt();
    int minutes = ((number - hour) * 60).toInt();
    return TimeOfDay(hour: hour, minute: minutes);
  }
}
