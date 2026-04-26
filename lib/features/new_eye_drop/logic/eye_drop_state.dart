// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'eye_drop_cubit.dart';

enum CubitStatus { initial, loading, success, error }

class EyeDropsState extends Equatable {
  final EyeDropsListModel eyeDropsListModel;
  final CubitStatus status;
  const EyeDropsState({
    required this.eyeDropsListModel,
    required this.status,
  });
  factory EyeDropsState.initial() {
    return EyeDropsState(
      eyeDropsListModel: _createDefaultEyeDrops(),
      status: CubitStatus.initial,
    );
  }

  static EyeDropsListModel _createDefaultEyeDrops() {
    final List<EyeDropModel> defaults = [
      EyeDropModel(
        name: 'Tymer ED',
        repetitions: 4,
        color: AppColors.scheduleColorsList[0],
        treatmentDuration: TreatmentDurationModel(
          startingDate: DateTime.now(),
          duration: const Duration(days: 30),
          selectedDurationOption: DurationOptions.durationChoice,
        ),
      ),
      EyeDropModel(
        name: 'Dexaflox ED',
        repetitions: 4,
        color: AppColors.scheduleColorsList[1],
        treatmentDuration: TreatmentDurationModel(
          startingDate: DateTime.now(),
          duration: const Duration(days: 30),
          selectedDurationOption: DurationOptions.durationChoice,
        ),
      ),
      EyeDropModel(
        name: 'Trillerg ED',
        repetitions: 3,
        color: AppColors.scheduleColorsList[2],
        treatmentDuration: TreatmentDurationModel(
          startingDate: DateTime.now(),
          duration: const Duration(days: 14),
          selectedDurationOption: DurationOptions.durationChoice,
        ),
      ),
      EyeDropModel(
        name: 'Conjyclear Forte SDU',
        repetitions: 3,
        color: AppColors.scheduleColorsList[3],
        treatmentDuration: TreatmentDurationModel(
          startingDate: DateTime.now(),
          duration: const Duration(days: 14),
          selectedDurationOption: DurationOptions.durationChoice,
        ),
      ),
    ];
    return EyeDropsListModel(items: defaults);
  }

  EyeDropsState loading() {
    return copyWith(
      status: CubitStatus.loading,
    );
  }

  EyeDropsState updateList(EyeDropsListModel eyeDropsListModel) {
    return EyeDropsState(
      eyeDropsListModel: eyeDropsListModel,
      status: CubitStatus.success,
    );
  }

  EyeDropsState copyWith({
    EyeDropsListModel? eyeDropsListModel,
    CubitStatus? status,
  }) {
    return EyeDropsState(
      eyeDropsListModel: eyeDropsListModel ?? this.eyeDropsListModel,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [eyeDropsListModel, status];
}
