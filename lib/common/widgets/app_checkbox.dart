import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors.dart';

class AppCheckbox extends StatefulWidget {
  final String label;
  final Function(bool) onValueChanged;
  final Function(bool) onInitial;
  final bool initialValue;

  const AppCheckbox({
    super.key,
    required this.label,
    required this.onValueChanged,
    required this.onInitial,
    this.initialValue = false,
  });

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    isSelected = widget.initialValue;
    widget.onInitial(isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: isSelected,
          onChanged: (value) {
            if (value != null) {
              isSelected = value;
              setState(() {});
              widget.onValueChanged(isSelected);
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
          style: const TextStyle(
            color: AppColors.grey500,
          ),
        ),
      ],
    );
  }
}
