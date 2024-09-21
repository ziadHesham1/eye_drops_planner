import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());
  // late final TimePickerController statingTimeController =
  //     TimePickerController(TimeOfDay.now());
  // late final TimePickerController endingTimeController =
  //     TimePickerController(TimeOfDay.now());
  SettingsState onValuesUpdated({
    TimeOfDay? startingTime,
    TimeOfDay? endingTime,
  }) {
    return SettingsState(
      startingTime: startingTime,
      endingTime: endingTime,
    );
  }
}
