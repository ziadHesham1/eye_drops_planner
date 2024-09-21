part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final TimeOfDay? startingTime;
  final TimeOfDay? endingTime;
  const SettingsState({
    required this.startingTime,
    required this.endingTime,
  });
  factory SettingsState.initial() {
    return const SettingsState(
      endingTime: TimeOfDay(hour: 8, minute: 0),
      startingTime: TimeOfDay(hour: 24, minute: 0),
    );
  }

  SettingsState copyWith({
    TimeOfDay? startingTime,
    TimeOfDay? endingTime,
  }) {
    return SettingsState(
      startingTime: startingTime ?? this.startingTime,
      endingTime: endingTime ?? this.endingTime,
    );
  }

  @override
  List<Object?> get props => [
        startingTime,
        endingTime,
      ];
}
