import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_colors.dart';

class AppCheckbox extends StatefulWidget {
  final String label;
  final Function(bool) onChanged;
  const AppCheckbox({
    super.key,
    required this.label,
    required this.onChanged,
  });

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isSelected,
          onChanged: (value) {
            if (value != null) {
              isSelected = value;
              setState(() {});
              widget.onChanged(isSelected);
            }
          },
          activeColor: AppColors.primary,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6.r),
            ),
          ),
        ),
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.grey300,
          ),
        ),
      ],
    );
  }
}
