// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:bill_planner/common/helpers/extensions.dart';

import '../../features/new_eye_drop/data/models/eye_drop_model.dart';

enum ScheduleItemStatus { normal, taken, missed }

extension ScheduleItemStatusExtension on ScheduleItemStatus {
  // Convert ScheduleItemStatus to a Map
  Map<String, String> toMap() {
    return {
      'status': toString().split('.').last,
    };
  }

  // Convert a Map to ScheduleItemStatus
  static ScheduleItemStatus fromMap(Map<String, String> statusMap) {
    return ScheduleItemStatus.values.firstWhere(
      (status) => status.toString().split('.').last == statusMap['status'],
      orElse: () => ScheduleItemStatus.normal, // Default value
    );
  }
}

class ScheduleItemModel extends Equatable {
  final int index;
  final EyeDropModel eyeDrop;
  final TimeOfDay time;
  final ScheduleItemStatus status;
  final bool taken;

  ScheduleItemModel({
    ScheduleItemStatus? status,
    required this.eyeDrop,
    required this.index,
    required this.time,
    this.taken = false,
  }) : status = _status(time, status, taken);

  static _status(TimeOfDay time, ScheduleItemStatus? status, bool taken) {
    if (status != null) {
      return status;
    } else if (DateTime.now().isAfter(time.toDateTime)) {
      if (taken) {
        return ScheduleItemStatus.taken;
      } else {
        return ScheduleItemStatus.missed;
      }
    } else {
      return ScheduleItemStatus.normal;
    }
  }

  @override
  String toString() => '${index + 1} - $eyeDrop | ${time.formatTimeOfDay}\n';

  @override
  List<Object> get props {
    return [
      index,
      eyeDrop,
      time,
      status,
      taken,
    ];
  }

  ScheduleItemModel copyWith({
    int? index,
    EyeDropModel? eyeDrop,
    TimeOfDay? time,
    ScheduleItemStatus? status,
    bool? taken,
  }) {
    return ScheduleItemModel(
      index: index ?? this.index,
      eyeDrop: eyeDrop ?? this.eyeDrop,
      time: time ?? this.time,
      status: status ?? this.status,
      taken: taken ?? this.taken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'index': index,
      'eyeDrop': eyeDrop.toMap(),
      'time': time.toMap(),
      'status': status.toMap,
      'taken': taken,
    };
  }

  factory ScheduleItemModel.fromMap(Map<String, dynamic> map) {
    return ScheduleItemModel(
      index: map['index'] as int,
      eyeDrop: EyeDropModel.fromMap(map['eyeDrop'] as Map<String, dynamic>),
      time: TimeOfDayExtension.fromMap(map['time'] as Map<String, int>),
      status: ScheduleItemStatusExtension.fromMap(
          map['status'] as Map<String, String>),
      taken: map['taken'] as bool,
    );
  }
}
