import 'package:bill_planner/features/home/logic/schedule_cubit.dart';
import 'package:bill_planner/features/new_eye_drop/logic/eye_drop_cubit.dart';
import 'package:bill_planner/features/settings/logic/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleListeners extends StatelessWidget {
  final Widget child;
  const ScheduleListeners({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: const [
        // BlocListener<EyeDropsCubit, EyeDropsState>(
        //   listener: (context, state) {
        //     context.read<ScheduleCubit>().onUpdateValue(
        //           eyeDropsList: state.eyeDropsListModel.items,
        //         );
        //     context.read<ScheduleCubit>().onUpdateSchedule();
        //   },
        //   child: child,
        // ),
        // BlocListener<SettingsCubit, SettingsState>(
        //   listener: (context, state) {
        //     context.read<ScheduleCubit>().onUpdateValue(
        //           startingTime: state.startingTime,
        //           endingTime: state.endingTime,
        //         );
        //     context.read<ScheduleCubit>().onUpdateSchedule();
        //   },
        //   child: child,
        // ),
      ],
      child: child,
    );
  }
}
