import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/services/notifications_service.dart';
import '../../../new_eye_drop/logic/eye_drop_cubit.dart';
import '../../../settings/logic/settings_cubit.dart';
import '../../logic/schedule_cubit.dart';

class ScheduleListeners extends StatefulWidget {
  final Widget child;
  const ScheduleListeners({super.key, required this.child});

  @override
  State<ScheduleListeners> createState() => _ScheduleListenersState();
}

class _ScheduleListenersState extends State<ScheduleListeners> {
  bool _permissionsRequested = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_permissionsRequested) return;
      _permissionsRequested = true;
      await NotificationsService.instance.requestPermissions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EyeDropsCubit, EyeDropsState>(
          listener: (context, state) {
            context.read<ScheduleCubit>().onUpdateValue(
                  eyeDropsList: state.eyeDropsListModel.items,
                );
            context.read<ScheduleCubit>().onUpdateSchedule();
          },
        ),
        BlocListener<SettingsCubit, SettingsState>(
          listener: (context, state) {
            context.read<ScheduleCubit>().onUpdateValue(
                  startingTime: state.startingTime,
                  endingTime: state.endingTime,
                );
            context.read<ScheduleCubit>().onUpdateSchedule();
          },
        ),
        BlocListener<ScheduleCubit, ScheduleState>(
          listenWhen: (prev, curr) => prev.schedule != curr.schedule,
          listener: (context, state) async {
            // Only schedule notifications when the user is viewing today's
            // schedule — past days are read-only views, future days will be
            // re-derived when that day arrives.
            final today = DateTime.now();
            final selected = state.selectedDate;
            final isToday = selected.year == today.year &&
                selected.month == today.month &&
                selected.day == today.day;

            await NotificationsService.instance.cancelAll();
            if (!isToday) return;

            final schedule = state.schedule;
            if (schedule == null || schedule.items.isEmpty) return;

            for (int i = 0; i < schedule.items.length; i++) {
              final item = schedule.items[i];
              final when = DateTime(
                today.year,
                today.month,
                today.day,
                item.time.hour,
                item.time.minute,
              );
              if (!when.isAfter(DateTime.now())) continue;
              await NotificationsService.instance.scheduleDrop(
                id: NotificationsService.idFor(today, i),
                drug: item.eyeDrop.name,
                drops: 1,
                when: when,
              );
            }
          },
        ),
      ],
      child: widget.child,
    );
  }
}
