import 'package:bill_planner/features/new_eye_drop/data/models/duration_option_model.dart';
import 'package:bill_planner/features/new_eye_drop/data/models/treatment_duration_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_colors.dart';
import '../../logic/eye_drop_cubit.dart';
import 'days_picker_bottom_sheet.dart';
import 'form_action_button.dart';
import 'treatment_duration_options_widget.dart';

class TreatmentDurationSectionWidget extends StatefulWidget {
  const TreatmentDurationSectionWidget({super.key});

  @override
  State<TreatmentDurationSectionWidget> createState() =>
      _TreatmentDurationSectionWidgetState();
}

class _TreatmentDurationSectionWidgetState
    extends State<TreatmentDurationSectionWidget> {
  Duration? selectedDuration;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const FormActionButton(
          icon: Icons.calendar_month,
          label: 'How long is your treatment duration?',
        ),
        TreatmentDurationOptionsWidget(
          onValueChanged: onDurationSelected,
          onInitial: onDurationSelected,
        ),
      ],
    );
  }

  void onDurationSelected(DurationOptionModel selectedOption) async {
    if (selectedOption.name == 'Set number of days') {
      int? result = await showModalBottomSheet(
        backgroundColor: AppColors.white,
        context: context,
        builder: (context) => DaysPickerBottomSheet(),
      );
      selectedDuration = Duration(days: result!);
    } else if (selectedOption.durationOption == DurationOptions.endDateChoice) {
      FocusScope.of(context).requestFocus(FocusNode());
      DateTime endingDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100)) ??
          DateTime(1900);
      selectedDuration = endingDate.difference(DateTime.now());
    } else if (selectedOption.durationOption == DurationOptions.outgoing) {
      selectedDuration = null;
    } else {
      selectedDuration = selectedOption.duration;
    }
    updateDuration(selectedOption);
  }

  void updateDuration(DurationOptionModel selectedOption) {
    context.read<EyeDropsCubit>().onUpdateNewEyeDrop(
          duration: selectedDuration,
          selectedDurationOption: selectedOption.durationOption,
        );
  }
}
