import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/fields/time_picker_field.dart';
import '../logic/settings_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, a});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Time Picker Example'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TimePickerField(
                    labelText: 'Stating Time',
                    onTimeChanged: (TimeOfDay timeOfDay) {
                      context
                          .read<SettingsCubit>()
                          .onValuesUpdated(startingTime: timeOfDay);
                    },
                  )),
                  SizedBox(width: 10.w),
                  Expanded(
                      child: TimePickerField(
                    labelText: 'Ending Time',
                    onTimeChanged: (TimeOfDay timeOfDay) {
                      context
                          .read<SettingsCubit>()
                          .onValuesUpdated(endingTime: timeOfDay);
                    },
                  )),
                ],
              ),
            ],
          ),
        ));
  }
}
