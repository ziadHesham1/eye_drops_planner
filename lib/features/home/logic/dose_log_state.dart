part of 'dose_log_cubit.dart';

class DoseLogState extends Equatable {
  final Map<String, bool> taken;
  const DoseLogState({required this.taken});

  @override
  List<Object?> get props => [taken];
}
