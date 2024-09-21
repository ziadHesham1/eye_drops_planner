// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ui';

import 'package:bill_planner/features/new_eye_drop/data/models/duration_option_model.dart';
import 'package:equatable/equatable.dart';

enum DurationOptions {
  /// is always active & (start,end and duration is null)
  outgoing,

  /// should have starting date and duration is calculated > give model both end time and duration
  endDateChoice,

  /// should have starting date and end date is calculated
  durationChoice,
}

class TreatmentDurationModel extends Equatable {
  final Duration? duration;
  final DateTime? startingDate;
  final DateTime? endingDate;
  final DurationOptions? selectedDurationOption;

  TreatmentDurationModel({
    DateTime? startingDate,
    DateTime? endingDate,
    Duration? duration,
    required this.selectedDurationOption,
  })  : startingDate = startingDate ?? DateTime.now(),
        endingDate = _calculateEndingDate(
            endingDate, startingDate, duration, selectedDurationOption),
        duration = _calculateDuration(
            endingDate, startingDate, duration, selectedDurationOption);
  factory TreatmentDurationModel.empty() {
    return TreatmentDurationModel(
      duration: null,
      startingDate: null,
      endingDate: null,
      selectedDurationOption: null,
    );
  }

  //--------------< Helper functions >--------------
  get isOutgoingChoiceValid =>
      selectedDurationOption == DurationOptions.outgoing;

  get isEndDateChoiceValid =>
      selectedDurationOption == DurationOptions.endDateChoice &&
      endingDate != null &&
      startingDate != null;

  get isDurationChoiceValid =>
      selectedDurationOption == DurationOptions.durationChoice &&
      startingDate != null &&
      duration != null;
// Helper function to calculate endingDate
  static DateTime? _calculateEndingDate(
    DateTime? endingDate,
    DateTime? startingDate,
    Duration? duration,
    DurationOptions? selectedDurationOption,
  ) {
    if (endingDate != null) return endingDate;
    bool isDurationChoiceValid =
        selectedDurationOption == DurationOptions.durationChoice &&
            startingDate != null &&
            duration != null;

    if (isDurationChoiceValid) {
      return startingDate.add(duration);
    }
    return null;
  }

  static Duration? _calculateDuration(
    DateTime? endingDate,
    DateTime? startingDate,
    Duration? duration,
    DurationOptions? selectedDurationOption,
  ) {
    if (duration != null) return duration;
    bool isEndDateChoiceValid =
        selectedDurationOption == DurationOptions.endDateChoice &&
            endingDate != null &&
            startingDate != null;
    if (isEndDateChoiceValid) {
      return startingDate.difference(endingDate);
    }
    return null;
  }
  //--------------< End of Helper functions >--------------

  // Factory constructor from Map
  factory TreatmentDurationModel.fromMap(Map<String, dynamic> map) {
    return TreatmentDurationModel(
      duration: map['duration'] != null
          ? Duration(days: map['duration'] as int)
          : null,
      startingDate: map['startingDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startingDate'] as int)
          : null,
      endingDate: map['endingDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endingDate'] as int)
          : null,
      selectedDurationOption: map['selectedDurationOption'] != null
          ? DurationOptions.values.firstWhere(
              (element) => element.name == map['selectedDurationOption'],
              orElse: () => DurationOptions.outgoing,
            )
          : null,
    );
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'duration': duration?.inDays,
      'startingDate': startingDate?.millisecondsSinceEpoch,
      'endingDate': endingDate?.millisecondsSinceEpoch,
      'selectedDurationOption': selectedDurationOption?.name,
    };
  }

  // Copy with new values
  TreatmentDurationModel copyWith({
    String? name,
    int? repetitions,
    Duration? duration,
    DateTime? startingDate,
    DateTime? endingDate,
    Color? color,
    DurationOptions? selectedDurationOption,
  }) {
    return TreatmentDurationModel(
      duration: duration ?? this.duration,
      startingDate: startingDate ?? this.startingDate,
      endingDate: endingDate ?? this.endingDate,
      selectedDurationOption:
          selectedDurationOption ?? this.selectedDurationOption,
    );
  }

  TreatmentDurationModel copy() {
    return TreatmentDurationModel(
      duration: duration,
      startingDate: startingDate,
      endingDate: endingDate,
      selectedDurationOption: selectedDurationOption,
    );
  }

  @override
  List<Object?> get props {
    return [
      duration,
      startingDate,
      endingDate,
      selectedDurationOption,
    ];
  }
}

List<DurationOptionModel> durationOptionsList = [
  const DurationOptionModel(
    name: '1 week',
    duration: Duration(days: 7),
    durationOption: DurationOptions.durationChoice,
  ),
  const DurationOptionModel(
    name: '2 weeks',
    duration: Duration(days: 14),
    durationOption: DurationOptions.durationChoice,
  ),
  const DurationOptionModel(
    name: '30 days',
    duration: Duration(days: 30),
    durationOption: DurationOptions.durationChoice,
  ),
  const DurationOptionModel(
    name: '2 Months',
    duration: Duration(days: 60),
    durationOption: DurationOptions.durationChoice,
  ),
  // DurationOptionModel(
  //   name: '3 Months',
  //   duration: const Duration(days: 90),
  //   durationOption: DurationOptions.chooseDuration,
  // ),
  const DurationOptionModel(
    name: 'Set number of days',
    duration: Duration(days: 0),
    durationOption: DurationOptions.durationChoice,
  ),
  const DurationOptionModel(
    name: 'Set end date',
    duration: Duration(days: 0),
    durationOption: DurationOptions.endDateChoice,
  ),
  const DurationOptionModel(
    name: 'Ongoing treatment, no end date',
    duration: Duration(days: 0),
    durationOption: DurationOptions.outgoing,
  ),
];
