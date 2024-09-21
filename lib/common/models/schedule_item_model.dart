// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bill_planner/common/helpers/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../features/new_eye_drop/data/models/eye_drop_model.dart';

enum ScheduleItemStatus { normal, taken, missed }

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
}
