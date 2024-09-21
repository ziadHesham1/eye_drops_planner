import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

class ValidationErrorWidget extends StatelessWidget {
  const ValidationErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.error50,
          borderRadius: BorderRadius.all(Radius.circular(4.r))),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: AppColors.error300,
          ),
          SizedBox(width: 4.w),
          Text(
            'Fill the required fields',
            style: TextStyle(
              color: AppColors.error300,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
