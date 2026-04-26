import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/models/schedule_item_model.dart';
import '../../../../common/widgets/app_icon_with_text.dart';
import '../../logic/dose_log_cubit.dart';

class HomeScheduleItemWidget extends StatelessWidget {
  final Color? color;
  final ScheduleItemModel scheduleItem;
  final DateTime date;

  const HomeScheduleItemWidget({
    super.key,
    this.color,
    required this.scheduleItem,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final taken = context.select<DoseLogCubit, bool>(
      (cubit) => cubit.isTaken(
        date,
        scheduleItem.index,
        scheduleItem.eyeDrop.name,
      ),
    );

    return InkWell(
      onTap: () {
        context.read<DoseLogCubit>().toggleTaken(
              date,
              scheduleItem.index,
              scheduleItem.eyeDrop.name,
            );
      },
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            Container(
              width: 60.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  AppAssets.waterDropSvg,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    scheduleItem.eyeDrop.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      decoration: taken ? TextDecoration.lineThrough : null,
                      color: taken ? Colors.grey : null,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  _dropsLeftWidget(),
                  SizedBox(height: 8.h),
                  dateInfoWidget(),
                ],
              ),
            ),
            SizedBox(width: 20.w),
            Icon(
              taken ? Icons.check_circle : Icons.chevron_right,
              color: taken ? Colors.green : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget dateInfoWidget() {
    int daysLeft = 0;
    String daysLeftText = 'N/A';

    if (scheduleItem.eyeDrop.treatmentDuration.endingDate != null) {
      daysLeft = scheduleItem.eyeDrop.treatmentDuration.endingDate!
          .difference(DateTime.now())
          .inDays;
      daysLeftText = '$daysLeft days left';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppIconWithText(icon: Icons.calendar_month_rounded, text: daysLeftText),
      ],
    );
  }

  Text _dropsLeftWidget() {
    final dropsLeft = scheduleItem.eyeDrop.repetitions - 1;
    String data;
    if (dropsLeft == 0) {
      data = 'No Drops left';
    } else if (dropsLeft == 1) {
      data = '$dropsLeft More Drop left';
    } else {
      data = '$dropsLeft More Drops left';
    }
    return Text(
      data,
      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
    );
  }
}
