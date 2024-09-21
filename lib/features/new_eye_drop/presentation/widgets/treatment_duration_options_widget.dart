import 'package:bill_planner/features/new_eye_drop/data/models/duration_option_model.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../data/models/treatment_duration_model.dart';

class TreatmentDurationOptionsWidget extends StatefulWidget {
  final Function(DurationOptionModel selectedDuration) onValueChanged;
  final Function(DurationOptionModel selectedDuration) onInitial;
  const TreatmentDurationOptionsWidget({
    super.key,
    required this.onValueChanged,
    required this.onInitial,
  });

  @override
  State<TreatmentDurationOptionsWidget> createState() =>
      _ChooseTimePeriodState();
}

class _ChooseTimePeriodState extends State<TreatmentDurationOptionsWidget> {
  late DurationOptionModel selectedItem;
  @override
  void initState() {
    super.initState();
    selectedItem = durationOptionsList[0];
    widget.onInitial(selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return ChipsChoice.single(
      alignment: WrapAlignment.center,
      wrapped: true,
      padding: EdgeInsets.zero,
      value: selectedItem,
      onChanged: (val) {
        setState(() => selectedItem = val);
        widget.onValueChanged(selectedItem);
      },
      choiceItems: durationOptionsList
          .map((e) => C2Choice(value: e, label: e.name))
          .toList(),
      choiceStyle: C2ChipStyle.filled(
        foregroundStyle: AppTextStyles.font14,
        selectedStyle: C2ChipStyle(
          foregroundStyle: AppTextStyles.font14White,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
          height: 40.h,
          backgroundColor: AppColors.primary,
        ),
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
        height: 35.h,
      ),
    );
  }
}
