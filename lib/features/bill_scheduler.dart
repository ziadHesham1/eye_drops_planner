import 'package:flutter/material.dart';

import '../common/helpers/extensions.dart';

class BillScheduler {
  final int numberOfDrops;
  final TimeOfDay startingTime;
  final TimeOfDay endingTime;

  /// Minimum minutes between two adjacent scheduled events (across drugs).
  /// Applied as a post-pass after even spacing.
  final int minGapMinutes;

  BillScheduler({
    required this.numberOfDrops,
    required this.startingTime,
    required this.endingTime,
    this.minGapMinutes = 6,
  });

  List<TimeOfDay> generateTimingList() {
    if (numberOfDrops <= 0) return const [];

    final windowMinutes = endingTime.difference(startingTime).inMinutes;
    if (windowMinutes <= 0) {
      // Degenerate window: stack everything at start.
      return List.filled(numberOfDrops, startingTime);
    }

    final intervalMin = windowMinutes / numberOfDrops;

    // Even spacing first.
    final base = DateTime(2000, 1, 1, startingTime.hour, startingTime.minute);
    final slots = <DateTime>[
      for (int i = 0; i < numberOfDrops; i++)
        base.add(Duration(milliseconds: (i * intervalMin * 60000).round())),
    ];

    _enforceMinGap(slots);

    // Clamp to within-day if a tight window pushed slots past midnight.
    final dayEnd = DateTime(2000, 1, 1, 23, 59);
    return slots.map((dt) {
      final t = dt.isAfter(dayEnd) ? dayEnd : dt;
      return TimeOfDay(hour: t.hour, minute: t.minute);
    }).toList();
  }

  /// Ensures every adjacent pair is at least [minGapMinutes] apart. When
  /// the window is too tight, slots spill past the original end rather than
  /// stack — keeping ordering and the cross-drug gap intact.
  void _enforceMinGap(List<DateTime> slots) {
    if (slots.length < 2) return;
    final gap = Duration(minutes: minGapMinutes);

    for (int i = 1; i < slots.length; i++) {
      final earliest = slots[i - 1].add(gap);
      if (slots[i].isBefore(earliest)) {
        slots[i] = earliest;
      }
    }
  }
}
