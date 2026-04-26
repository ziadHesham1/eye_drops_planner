import 'package:bill_planner/common/helpers/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/models/schedule_model.dart';
import '../../bill_scheduler.dart';
import '../../new_eye_drop/data/models/eye_drop_model.dart';
import '../../new_eye_drop/data/models/eye_drops_list_model.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit() : super(ScheduleState.initial());

  void onUpdateSchedule() {
    if (!state.scheduleIsValid) {
      emit(state.resetSchedule());
      return;
    }
    final schedule = generateNewSchedule();
    emit(state.updateSchedule(schedule));
  }

  ScheduleModel generateNewSchedule() {
    final all = state.eyeDropsList ?? const <EyeDropModel>[];
    final activeToday =
        EyeDropsListModel(items: all).activeOn(state.selectedDate);

    if (activeToday.isEmpty) {
      return ScheduleModel.empty();
    }

    final totalDrops =
        activeToday.fold<int>(0, (sum, d) => sum + d.repetitions);
    if (totalDrops <= 0) {
      return ScheduleModel.empty();
    }

    final scheduler = BillScheduler(
      numberOfDrops: totalDrops,
      startingTime: state.startingTime!,
      endingTime: state.endingTime!,
    );
    final timingList = scheduler.generateTimingList();

    // ScheduleModel.generate mutates the bills list — pass a deep copy.
    final bills = activeToday.map((d) => d.copy()).toList();
    return ScheduleModel.generate(timingList, bills);
  }

  void onUpdateValue({
    List<EyeDropModel>? eyeDropsList,
    TimeOfDay? startingTime,
    TimeOfDay? endingTime,
    DateTime? selectedDate,
  }) {
    emit(state.copyWith(
      eyeDropsList: eyeDropsList,
      startingTime: startingTime,
      endingTime: endingTime,
      selectedDate: selectedDate,
    ));
  }
}
