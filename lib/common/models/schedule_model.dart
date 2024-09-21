// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../features/new_eye_drop/data/models/eye_drop_model.dart';
import 'schedule_item_model.dart';

class ScheduleModel extends Equatable {
  final List<ScheduleItemModel> items;
  factory ScheduleModel.empty() {
    return const ScheduleModel(items: []);
  }
  const ScheduleModel({required this.items});
  factory ScheduleModel.generate(
      List<TimeOfDay> timesList, List<EyeDropModel> bills) {
    List<ScheduleItemModel> schedule = [];

    int billsIterator = 0;
    for (int timeIterator = 0;
        timeIterator < timesList.length;
        timeIterator++) {
      EyeDropModel bill = bills[billsIterator];

      if (bill.repetitions <= 0) {
        billsIterator++;
      }

      if (bill.repetitions > 0) {
        schedule.add(
          ScheduleItemModel(
              eyeDrop: bill,
              time: timesList[timeIterator],
              index: billsIterator),
        );
        bills[billsIterator] = bill.copyWith(repetitions: bill.repetitions - 1);
      } else {
        /// when a bill is skipped because it has no more repetitions
        /// reduce the time iterator by 1 to give that time to the next bill
        timeIterator--;
      }

      /// reset the bill iterator when it achieves the last bill
      if (billsIterator < bills.length - 1) {
        billsIterator++;
      } else {
        billsIterator = 0;
      }
    }
    return ScheduleModel(items: schedule);
  }

  @override
  List<Object> get props => [items];

  ScheduleModel copyWith({
    List<ScheduleItemModel>? items,
  }) {
    return ScheduleModel(
      items: items ?? this.items,
    );
  }
}
