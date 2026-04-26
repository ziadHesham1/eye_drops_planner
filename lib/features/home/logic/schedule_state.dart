part of 'schedule_cubit.dart';

class ScheduleState extends Equatable {
  final List<EyeDropModel>? eyeDropsList;
  final TimeOfDay? startingTime;
  final TimeOfDay? endingTime;
  final ScheduleModel? schedule;
  final DateTime selectedDate;

  const ScheduleState({
    required this.eyeDropsList,
    required this.startingTime,
    required this.endingTime,
    required this.schedule,
    required this.selectedDate,
  });

  factory ScheduleState.initial() {
    final now = DateTime.now();
    return ScheduleState(
      schedule: const ScheduleModel(items: []),
      eyeDropsList: const [],
      startingTime: const TimeOfDay(hour: 9, minute: 0),
      endingTime: const TimeOfDay(hour: 21, minute: 0),
      selectedDate: DateTime(now.year, now.month, now.day),
    );
  }

  ScheduleState resetSchedule() {
    return copyWith(schedule: const ScheduleModel(items: []));
  }

  ScheduleState updateSchedule(ScheduleModel schedule) {
    return copyWith(schedule: schedule);
  }

  bool get scheduleIsValid =>
      startingTime.isNotNull &&
      endingTime.isNotNull &&
      eyeDropsList.isNotNullOrEmpty;

  ScheduleState copyWith({
    List<EyeDropModel>? eyeDropsList,
    TimeOfDay? startingTime,
    TimeOfDay? endingTime,
    ScheduleModel? schedule,
    DateTime? selectedDate,
  }) {
    return ScheduleState(
      eyeDropsList: eyeDropsList ?? this.eyeDropsList,
      startingTime: startingTime ?? this.startingTime,
      endingTime: endingTime ?? this.endingTime,
      schedule: schedule ?? this.schedule,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [
        eyeDropsList,
        startingTime,
        endingTime,
        schedule,
        selectedDate,
      ];
}
