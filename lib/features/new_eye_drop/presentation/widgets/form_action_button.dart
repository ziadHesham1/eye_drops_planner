import 'package:bill_planner/common/app_colors.dart';
import 'package:bill_planner/common/widgets/buttons/app_container_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function()? onPressed;
  const FormActionButton(
      {super.key, required this.icon, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppContainerButton(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(
        vertical: 18.h,
        horizontal: 12.w,
      ),
      margin: EdgeInsets.symmetric(vertical: 12.w),
      color: AppColors.primary.withOpacity(0.1),
      borderRadius: 20,
      // height: 120.h,
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
