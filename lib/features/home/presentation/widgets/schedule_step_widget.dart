import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/models/schedule_item_model.dart';

class ScheduleStepWidget extends StatelessWidget {
  final String title;
  final Widget content;
  final bool isFirst;
  final bool isLast;
  final Color indicatorColor;
  final ScheduleItemStatus status;

  const ScheduleStepWidget({
    super.key,
    required this.title,
    required this.content,
    required this.isFirst,
    required this.isLast,
    required this.indicatorColor,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    var normalIndicatorStyle = IndicatorStyle(
      width: 20.w,
      height: 20.h,
      indicator: CircleAvatar(backgroundColor: indicatorColor),
      padding: EdgeInsets.zero,
    );
    var takenIndicatorStyle = IndicatorStyle(
      width: 30.w,
      height: 30.h,
      indicator: CircleAvatar(
        backgroundColor: indicatorColor,
        child: const Padding(
          padding: EdgeInsets.all(3.0),
          child: Icon(Icons.check, color: Colors.white),
        ),
      ),
      padding: EdgeInsets.zero,
    );
    var missedIndicatorStyle = IndicatorStyle(
      width: 30.w,
      height: 30.h,
      indicator: const CircleAvatar(
        backgroundColor: Colors.red,
        child: Padding(
          padding: EdgeInsets.all(3.0),
          child: Icon(Icons.error, color: AppColors.white),
        ),
      ),
      padding: EdgeInsets.zero,
    );
    indicatorStyle() {
      switch (status) {
        case ScheduleItemStatus.normal:
          return normalIndicatorStyle;
        case ScheduleItemStatus.taken:
          return takenIndicatorStyle;
        case ScheduleItemStatus.missed:
          return missedIndicatorStyle;
      }
    }

    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.06,
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: const LineStyle(
        color: Colors.grey,
        thickness: 2,
      ),
      afterLineStyle: const LineStyle(
        color: Colors.grey,
        thickness: 2,
      ),
      indicatorStyle: indicatorStyle(),
      endChild: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            content,
          ],
        ),
      ),
    );
  }
}
