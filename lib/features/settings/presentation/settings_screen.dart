import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/fields/time_picker_field.dart';
import '../logic/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    'Daily reminder window',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: const Text(
                    'Drops are evenly spaced across this window each day.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TimePickerField(
                        labelText: 'Starts at',
                        initialTime: state.startingTime,
                        onTimeChanged: (t) => context
                            .read<SettingsCubit>()
                            .onValuesUpdated(startingTime: t),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TimePickerField(
                        labelText: 'Ends at',
                        initialTime: state.endingTime,
                        onTimeChanged: (t) => context
                            .read<SettingsCubit>()
                            .onValuesUpdated(endingTime: t),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
