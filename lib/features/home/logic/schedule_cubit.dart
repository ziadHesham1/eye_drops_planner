import 'package:bill_planner/common/helpers/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/models/schedule_model.dart';
import '../../bill_scheduler.dart';
import '../../new_eye_drop/data/models/eye_drop_model.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit() : super(ScheduleState.initial());

  onUpdateSchedule() {
    // emit(state.resetSchedule());

    if (state.scheduleIsValid) {
      ScheduleModel schedule = generateNewSchedule();
      emit(state.updateSchedule(schedule));
    }
  }

  ScheduleModel generateNewSchedule() {
    BillScheduler billScheduler = BillScheduler(
      numberOfDrops: state.eyeDropsList!
          .fold(0, (total, bill) => total + bill.repetitions),
      startingTime: state.startingTime!,
      endingTime: state.endingTime!,
    );
    List<TimeOfDay> timingList = billScheduler.generateTimingList();
    ScheduleModel schedule =
        ScheduleModel.generate(timingList, state.eyeDropsList!);
    return schedule;
  }

  void onUpdateValue({
    List<EyeDropModel>? eyeDropsList,
    TimeOfDay? startingTime,
    TimeOfDay? endingTime,
    // ScheduleModel? schedule,
  }) {
    emit(state.copyWith(
      eyeDropsList: eyeDropsList,
      startingTime: startingTime,
      endingTime: endingTime,
      // schedule: schedule,
    ));
  }
}
