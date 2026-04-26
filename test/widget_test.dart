import 'package:bill_planner/features/bill_scheduler.dart';
import 'package:bill_planner/features/new_eye_drop/data/models/eye_drop_model.dart';
import 'package:bill_planner/features/new_eye_drop/data/models/eye_drops_list_model.dart';
import 'package:bill_planner/features/new_eye_drop/data/models/treatment_duration_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

EyeDropModel _drop({
  required String name,
  required int repetitions,
  required DurationOptions option,
  DateTime? start,
  DateTime? end,
  Duration? duration,
}) {
  return EyeDropModel(
    name: name,
    repetitions: repetitions,
    treatmentDuration: TreatmentDurationModel(
      selectedDurationOption: option,
      startingDate: start,
      endingDate: end,
      duration: duration,
    ),
  );
}

void main() {
  group('EyeDropsListModel.activeOn', () {
    test('outgoing prescription is active on any date', () {
      final list = EyeDropsListModel(items: [
        _drop(
          name: 'A',
          repetitions: 4,
          option: DurationOptions.outgoing,
        ),
      ]);
      expect(list.activeOn(DateTime(2030, 1, 1)).length, 1);
    });

    test('durationChoice active only within window (inclusive)', () {
      final start = DateTime(2026, 1, 10);
      final list = EyeDropsListModel(items: [
        _drop(
          name: 'A',
          repetitions: 4,
          option: DurationOptions.durationChoice,
          start: start,
          duration: const Duration(days: 14),
        ),
      ]);

      expect(list.activeOn(DateTime(2026, 1, 9)).length, 0,
          reason: 'before start');
      expect(list.activeOn(DateTime(2026, 1, 10)).length, 1,
          reason: 'on start');
      expect(list.activeOn(DateTime(2026, 1, 24)).length, 1,
          reason: 'on end (start + 14 days)');
      expect(list.activeOn(DateTime(2026, 1, 25)).length, 0,
          reason: 'after end');
    });

    test('activeItems returns config-valid items, not the inverse', () {
      final list = EyeDropsListModel(items: [
        _drop(name: 'A', repetitions: 1, option: DurationOptions.outgoing),
        // No selectedDurationOption → isActive == false → must be excluded.
        EyeDropModel(
          name: 'incomplete',
          repetitions: 1,
          treatmentDuration: TreatmentDurationModel.empty(),
        ),
      ]);
      expect(list.activeItems.length, 1);
      expect(list.activeItems.single.name, 'A');
    });
  });

  group('BillScheduler.generateTimingList', () {
    test('window not a whole-hour multiple still spreads evenly', () {
      final s = BillScheduler(
        numberOfDrops: 4,
        startingTime: const TimeOfDay(hour: 9, minute: 0),
        endingTime: const TimeOfDay(hour: 10, minute: 30),
      );
      final times = s.generateTimingList();
      // 90 minutes / 4 = 22.5 minute interval starting at 9:00.
      expect(times.length, 4);
      expect(times[0], const TimeOfDay(hour: 9, minute: 0));
      expect(times[1], const TimeOfDay(hour: 9, minute: 22));
      expect(times[2], const TimeOfDay(hour: 9, minute: 45));
      expect(times[3], const TimeOfDay(hour: 10, minute: 7));
    });

    test('min-gap pass pushes adjacent slots apart, spilling past window', () {
      final s = BillScheduler(
        numberOfDrops: 6,
        startingTime: const TimeOfDay(hour: 9, minute: 0),
        endingTime: const TimeOfDay(hour: 9, minute: 20),
        minGapMinutes: 6,
      );
      final times = s.generateTimingList();
      // 20-minute window with 6 slots = ~3.3 min interval — pushed to 6.
      for (int i = 1; i < times.length; i++) {
        final prev = times[i - 1].hour * 60 + times[i - 1].minute;
        final cur = times[i].hour * 60 + times[i].minute;
        expect(cur - prev, greaterThanOrEqualTo(6),
            reason: 'pair $i: prev=$prev cur=$cur');
      }
    });

    test('14 drops across 9:00→21:00 window', () {
      final s = BillScheduler(
        numberOfDrops: 14,
        startingTime: const TimeOfDay(hour: 9, minute: 0),
        endingTime: const TimeOfDay(hour: 21, minute: 0),
      );
      final times = s.generateTimingList();
      expect(times.length, 14);
      expect(times.first, const TimeOfDay(hour: 9, minute: 0));
      // Last slot should still be before end-of-window.
      final last = times.last;
      expect(last.hour < 21 || (last.hour == 21 && last.minute == 0), isTrue);
    });
  });
}
