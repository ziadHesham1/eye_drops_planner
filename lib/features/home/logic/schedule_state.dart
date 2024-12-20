part of 'schedule_cubit.dart';

class ScheduleState extends Equatable {
  final List<EyeDropModel>? eyeDropsList;
  final TimeOfDay? startingTime;
  final TimeOfDay? endingTime;
  final ScheduleModel? schedule;
  const ScheduleState({
    required this.eyeDropsList,
    required this.startingTime,
    required this.endingTime,
    required this.schedule,
  });
  factory ScheduleState.initial() {
    return const ScheduleState(
      schedule: ScheduleModel(items: []),
      eyeDropsList: [],
      endingTime: TimeOfDay(hour: 0, minute: 0),
      startingTime: TimeOfDay(hour: 0, minute: 0),
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
  }) {
    return ScheduleState(
      eyeDropsList: eyeDropsList ?? this.eyeDropsList,
      startingTime: startingTime ?? this.startingTime,
      endingTime: endingTime ?? this.endingTime,
      schedule: schedule ?? this.schedule,
    );
  }

  @override
  List<Object?> get props => [
        eyeDropsList,
        startingTime,
        endingTime,
        schedule,
      ];
}
