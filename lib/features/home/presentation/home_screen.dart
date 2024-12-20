import 'package:bill_planner/features/home/presentation/widgets/schedule_listeners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/helpers/extensions.dart';
import '../../../common/models/schedule_model.dart';
import '../../new_eye_drop/data/models/eye_drop_model.dart';
import '../../new_eye_drop/logic/eye_drop_cubit.dart';
import '../../settings/logic/settings_cubit.dart';
import '../logic/schedule_cubit.dart';
import 'widgets/home_date_picker_widget.dart';
import 'widgets/home_schedule_item_widget.dart';
import 'widgets/schedule_step_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    print('HomeScreen initState');
    onScheduleRefresh();
  }

  void onScheduleRefresh() {
    TimeOfDay? startingTime = context.read<SettingsCubit>().state.startingTime!;
    TimeOfDay? endingTime = context.read<SettingsCubit>().state.endingTime;
    List<EyeDropModel> eyeDropsList =
        context.read<EyeDropsCubit>().state.eyeDropsListModel.items;
    context.read<ScheduleCubit>().onUpdateValue(
          eyeDropsList: eyeDropsList,
          startingTime: startingTime,
          endingTime: endingTime,
        );
    context.read<ScheduleCubit>().onUpdateSchedule();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ScheduleCubit, ScheduleState>(
            builder: (context, state) {
          ScheduleModel schedule = ScheduleModel.empty();
          if (state.schedule.isNotNullOrEmpty) {
            schedule = state.schedule!;
          }
          return Column(
            children: [
              // Text(schedule.items.length.toString()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HomeDatePickerWidget(
                  onDateSelected: (selectedDate) {},
                ),
              ),
              Expanded(
                child: ListView(
                  children: schedule.items.asMap().entries.map(
                    (entry) {
                      int i = entry.key;
                      return ScheduleStepWidget(
                        status: entry.value.status,
                        title: entry.value.time.to12HourString,
                        content: HomeScheduleItemWidget(
                          scheduleItem: entry.value,
                          color: entry.value.eyeDrop.color,
                        ),
                        isFirst: i == 0,
                        isLast: i == schedule.items.length - 1,
                        indicatorColor: entry.value.eyeDrop.color,
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
