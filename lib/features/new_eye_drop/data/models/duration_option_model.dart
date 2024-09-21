// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bill_planner/features/new_eye_drop/data/models/treatment_duration_model.dart';
import 'package:equatable/equatable.dart';

class DurationOptionModel extends Equatable {
  final String name;
  final Duration duration;
  final DurationOptions durationOption;

  const DurationOptionModel({
    required this.name,
    required this.duration,
    required this.durationOption,
  });

  @override
  List<Object> get props => [name, duration, durationOption];
}
