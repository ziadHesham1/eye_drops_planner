import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../common/helpers/extensions.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());

  void onValuesUpdated({
    TimeOfDay? startingTime,
    TimeOfDay? endingTime,
  }) {
    emit(state.copyWith(
      startingTime: startingTime,
      endingTime: endingTime,
    ));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    final start = json['startingTime'];
    final end = json['endingTime'];
    return SettingsState(
      startingTime: start is Map
          ? TimeOfDayExtension.fromMap(Map<String, int>.from(start))
          : null,
      endingTime: end is Map
          ? TimeOfDayExtension.fromMap(Map<String, int>.from(end))
          : null,
    );
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return {
      'startingTime': state.startingTime?.toMap(),
      'endingTime': state.endingTime?.toMap(),
    };
  }
}
