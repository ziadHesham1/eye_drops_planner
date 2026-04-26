import 'package:equatable/equatable.dart';

import 'eye_drop_model.dart';
import 'treatment_duration_model.dart';

class EyeDropsListModel extends Equatable {
  final List<EyeDropModel> items;

  const EyeDropsListModel({required this.items});
  factory EyeDropsListModel.empty() {
    return const EyeDropsListModel(items: []);
  }

  EyeDropsListModel addEyeDrop(EyeDropModel newEyeDrop) {
    return EyeDropsListModel(
      items: List<EyeDropModel>.from(items)..add(newEyeDrop),
    );
  }

  List<EyeDropModel> get activeItems {
    return items.where((element) => element.isActive == true).toList();
  }

  /// Returns prescriptions whose `selectedDurationOption` is valid AND whose
  /// active window covers `day` (date-only, ignoring time-of-day).
  List<EyeDropModel> activeOn(DateTime day) {
    final target = DateTime(day.year, day.month, day.day);
    return items.where((e) {
      if (!e.isActive) return false;
      final td = e.treatmentDuration;
      if (td.selectedDurationOption == DurationOptions.outgoing) return true;

      final start = td.startingDate;
      final end = td.endingDate;
      if (start == null || end == null) return false;
      final startDay = DateTime(start.year, start.month, start.day);
      final endDay = DateTime(end.year, end.month, end.day);
      return !target.isBefore(startDay) && !target.isAfter(endDay);
    }).toList();
  }

  @override
  List<Object> get props => [items];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory EyeDropsListModel.fromMap(Map<String, dynamic> map) {
    return EyeDropsListModel(
      items: List<EyeDropModel>.from(
        (map['items'] as List<dynamic>).map<EyeDropModel>(
          (x) => EyeDropModel.fromMap(x),
        ),
      ),
    );
  }
}
