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
      eyeDropsListModel: EyeDropsListModel.empty(),
      status: CubitStatus.initial,
    );
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
