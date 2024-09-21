// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:bill_planner/common/app_colors.dart';
import 'package:bill_planner/features/new_eye_drop/data/models/treatment_duration_model.dart';
import 'package:equatable/equatable.dart';

class EyeDropModel extends Equatable {
  final String name;
  final int repetitions;
  final TreatmentDurationModel treatmentDuration;
  final Color color;

  EyeDropModel({
    required this.treatmentDuration,
    required this.name,
    required this.repetitions,
    Color? color,
  }) : color = _getColor(color);
// Helper function to get color
  static Color _getColor(Color? color) =>
      color ?? AppColors.scheduleColorsList[1];
  // Empty factory constructor
  factory EyeDropModel.empty() {
    return EyeDropModel(
      name: '',
      repetitions: 0,
      treatmentDuration: TreatmentDurationModel.empty(),
    );
  }

  bool get isActive {
    bool result = false;
    switch (treatmentDuration.selectedDurationOption) {
      case DurationOptions.outgoing:
        result = treatmentDuration.isOutgoingChoiceValid;
      case DurationOptions.endDateChoice:
        result = treatmentDuration.isEndDateChoiceValid;
      case DurationOptions.durationChoice:
        result = treatmentDuration.isDurationChoiceValid;
      default:
        result = false;
    }

    return result;
  }

  // Factory constructor from Map
  factory EyeDropModel.fromMap(Map<String, dynamic> map) {
    return EyeDropModel(
      name: map['name'] as String,
      repetitions: map['repetitions'] as int,
      treatmentDuration:
          TreatmentDurationModel.fromMap(map['treatmentDuration']),
      color: Color(map['color'] as int),
    );
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'repetitions': repetitions,
      'color': color.value,
      'treatmentDuration': treatmentDuration.toMap(),
    };
  }

  // Copy with new values
  EyeDropModel copyWith({
    String? name,
    int? repetitions,
    Color? color,
    TreatmentDurationModel? treatmentDuration,
  }) {
    return EyeDropModel(
      name: name ?? this.name,
      repetitions: repetitions ?? this.repetitions,
      color: color ?? this.color,
      treatmentDuration: treatmentDuration ?? this.treatmentDuration,
    );
  }

  EyeDropModel copy() {
    return EyeDropModel(
      name: name,
      repetitions: repetitions,
      color: color,
      treatmentDuration: treatmentDuration.copy(),
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      repetitions,
      color,
      treatmentDuration,
    ];
  }
}
