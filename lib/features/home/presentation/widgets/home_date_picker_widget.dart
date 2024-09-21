import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/app_colors.dart';

class HomeDatePickerWidget extends StatefulWidget {
  final Function(DateTime selectedDate) onDateSelected;
  const HomeDatePickerWidget({super.key, required this.onDateSelected});

  @override
  State<HomeDatePickerWidget> createState() => _HomeDatePickerWidgetState();
}

class _HomeDatePickerWidgetState extends State<HomeDatePickerWidget> {
  // DateTime _selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      headerProps: const EasyHeaderProps(
        padding: EdgeInsets.zero,
        dateFormatter: DateFormatter.fullDateMonthAsStrDY(),
      ),
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        //`selectedDate` the new date selected.
        setState(() {
          // _selectedValue = selectedDate;
        });
        widget.onDateSelected(selectedDate);
      },
      dayProps: EasyDayProps(
        height: 56.0,
        width: 56.0,
        dayStructure: DayStructure.dayNumDayStr,
        inactiveDayStyle: DayStyle(
          decoration: BoxDecoration(
            color: AppColors.grey200,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          // borderRadius: 48.0,
          dayNumStyle: const TextStyle(
            fontSize: 18.0,
          ),
        ),
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          dayStrStyle: const TextStyle(
            color: Colors.white,
          ),
          dayNumStyle: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
