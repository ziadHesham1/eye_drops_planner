import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/helpers/extensions.dart';
import '../../../common/models/schedule_item_model.dart';
import '../../../common/models/schedule_model.dart';
import '../../new_eye_drop/data/models/eye_drop_model.dart';
import '../../new_eye_drop/logic/eye_drop_cubit.dart';
import '../../settings/logic/settings_cubit.dart';
import '../logic/dose_log_cubit.dart';
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
    onScheduleRefresh();
  }

  void onScheduleRefresh() {
    final settings = context.read<SettingsCubit>().state;
    final List<EyeDropModel> eyeDropsList =
        context.read<EyeDropsCubit>().state.eyeDropsListModel.items;
    context.read<ScheduleCubit>().onUpdateValue(
          eyeDropsList: eyeDropsList,
          startingTime: settings.startingTime,
          endingTime: settings.endingTime,
        );
    context.read<ScheduleCubit>().onUpdateSchedule();
  }

  void _onDateSelected(DateTime selectedDate) {
    final dayOnly =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    context.read<ScheduleCubit>().onUpdateValue(selectedDate: dayOnly);
    context.read<ScheduleCubit>().onUpdateSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ScheduleCubit, ScheduleState>(
          builder: (context, state) {
            final ScheduleModel schedule = state.schedule.isNotNullOrEmpty
                ? state.schedule!
                : ScheduleModel.empty();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HomeDatePickerWidget(onDateSelected: _onDateSelected),
                ),
                Expanded(
                  child: schedule.items.isEmpty
                      ? _EmptyState(
                          isToday: _isSameDay(
                            state.selectedDate,
                            DateTime.now(),
                          ),
                        )
                      : BlocBuilder<DoseLogCubit, DoseLogState>(
                          builder: (context, _) {
                            return ListView(
                              children:
                                  schedule.items.asMap().entries.map((entry) {
                                final i = entry.key;
                                final item = entry.value;
                                final status = _statusFor(
                                  context,
                                  item: item,
                                  date: state.selectedDate,
                                );
                                return ScheduleStepWidget(
                                  status: status,
                                  title: item.time.to12HourString,
                                  content: HomeScheduleItemWidget(
                                    scheduleItem: item,
                                    color: item.eyeDrop.color,
                                    date: state.selectedDate,
                                  ),
                                  isFirst: i == 0,
                                  isLast: i == schedule.items.length - 1,
                                  indicatorColor: item.eyeDrop.color,
                                );
                              }).toList(),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static ScheduleItemStatus _statusFor(
    BuildContext context, {
    required ScheduleItemModel item,
    required DateTime date,
  }) {
    final taken = context
        .read<DoseLogCubit>()
        .isTaken(date, item.index, item.eyeDrop.name);
    if (taken) return ScheduleItemStatus.taken;

    final slotTime = DateTime(
      date.year,
      date.month,
      date.day,
      item.time.hour,
      item.time.minute,
    );
    if (DateTime.now().isAfter(slotTime)) return ScheduleItemStatus.missed;
    return ScheduleItemStatus.normal;
  }
}

class _EmptyState extends StatelessWidget {
  final bool isToday;
  const _EmptyState({required this.isToday});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.water_drop_outlined,
                size: 64, color: Colors.grey),
            SizedBox(height: 12.h),
            Text(
              isToday
                  ? 'No drops scheduled for today'
                  : 'No drops scheduled for this day',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            const Text(
              'Add a prescription from the Eye Drops tab to get started.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
