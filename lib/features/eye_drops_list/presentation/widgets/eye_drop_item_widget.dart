import 'package:bill_planner/common/widgets/app_icon_with_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/helpers/extensions.dart';
import '../../../new_eye_drop/data/models/eye_drop_model.dart';

class EyeDropItemWidget extends StatelessWidget {
  final EyeDropModel eyeDrop;

  const EyeDropItemWidget({
    super.key,
    required this.eyeDrop,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 8.w,
        ),
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        height: 100.h,
        child: Row(
          children: [
            Container(
              width: 60.w,
              decoration: BoxDecoration(
                color: eyeDrop.color,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.r),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  eyeDrop.isActive
                      ? AppAssets.waterDropSvg
                      : AppAssets.pauseSvg,
                  height: 35.h,
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
                    eyeDrop.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        eyeDrop.treatmentDuration.duration == null
                            ? 'Outgoing Treatment'
                            : 'Duration: ${eyeDrop.treatmentDuration.duration?.inDays} days',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                          // fontWeight: FontWeight.w500,
                        ),
                      ),
                      _dropsLeftWidget(),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  dateInfoWidget()
                ],
              ),
            ),
            SizedBox(width: 20.w),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    ]);
  }

  Text _dropsLeftWidget() {
    var dropsNumber = eyeDrop.repetitions;
    String data;
    if (dropsNumber == 0) {
      data = '';
    } else {
      data = '$dropsNumber drop(s)';
    }
    return Text(
      // '10 tablets',
      data,
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.grey,
        // fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget dateInfoWidget() {
    TextStyle textStyle = TextStyle(fontSize: 14.sp, color: Colors.grey);

    if (!eyeDrop.isActive) {
      return Text('disabled', style: textStyle);
    }
    int daysLeft = 0;
    String daysLeftText = 'N/A';
    String startingDateText = 'N/A';

    if (eyeDrop.treatmentDuration.endingDate != null) {
      daysLeft = eyeDrop.treatmentDuration.endingDate!
          .difference(DateTime.now())
          .inDays;
      daysLeftText = '$daysLeft days left';
    }

    if (eyeDrop.treatmentDuration.startingDate != null) {
      startingDateText = eyeDrop.treatmentDuration.startingDate!.yMMMdFormat;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppIconWithText(icon: Icons.calendar_month_rounded, text: daysLeftText),
        Text(startingDateText, style: textStyle),
      ],
    );
  }
}
