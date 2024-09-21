import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_colors.dart';

class AppTextButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  final String? leadingText;
  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.leadingText,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingText != null) ...{
            Text(
              leadingText!,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.grey500,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
          },
          Text(
            label,
            style: TextStyle(
              fontSize: (leadingText != null) ? 14.sp : 12.sp,
              fontWeight: (leadingText != null) ? FontWeight.w500 : null,
              color:
                  (leadingText != null) ? AppColors.primary : AppColors.grey500,
            ),
          ),
        ],
      ),
    );
  }
}
