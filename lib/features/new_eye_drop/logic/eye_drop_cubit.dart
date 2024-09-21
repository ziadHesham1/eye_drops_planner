import 'dart:developer';
import 'dart:ui';

import 'package:bill_planner/features/new_eye_drop/data/models/treatment_duration_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../data/models/eye_drop_model.dart';
import '../data/models/eye_drops_list_model.dart';

part 'eye_drop_state.dart';

class EyeDropsCubit extends HydratedCubit<EyeDropsState> {
  EyeDropsCubit() : super(EyeDropsState.initial());

  EyeDropModel _newEyeDropModel = EyeDropModel.empty();
  void onUpdateNewEyeDrop({
    String? name,
    int? repetitions,
    Duration? duration,
    DateTime? startingDate,
    DateTime? endingDate,
    Color? color,
    bool? disabled,
    DurationOptions? selectedDurationOption,
  }) {
    _newEyeDropModel = _newEyeDropModel.copyWith(
        name: name,
        repetitions: repetitions,
        color: color,
        treatmentDuration: _newEyeDropModel.treatmentDuration.copyWith(
          duration: duration,
          startingDate: startingDate,
          endingDate: endingDate,
          selectedDurationOption: selectedDurationOption,
        ));
  }

  onCreateNewEyeDrop() {
    emit(state.loading());
    EyeDropModel newItem = _newEyeDropModel.copy();
    var eyeDropsListModel = state.eyeDropsListModel.addEyeDrop(newItem);

    log('Adding new eye drop: ${_newEyeDropModel.name},ending date: ${newItem.treatmentDuration.endingDate}');
    emit(state.updateList(eyeDropsListModel));

    log('New state emitted with ${eyeDropsListModel.items.length} eye drops.');
  }

  onClearEyeDrops() {
    emit(EyeDropsState.initial());
  }

  @override
  EyeDropsState? fromJson(Map<String, dynamic> json) {
    log('eye_drop_cubit >' 'from json > length = ${json['items'].length}');
    return EyeDropsState(
      eyeDropsListModel: EyeDropsListModel.fromMap(json),
      status: CubitStatus.success,
    );
  }

  @override
  Map<String, dynamic>? toJson(EyeDropsState state) {
    log('eye_drop_cubit >'
        'from json >length = ${state.eyeDropsListModel.items.length}');
    // return {};
    return state.eyeDropsListModel.toMap();
  }
}
