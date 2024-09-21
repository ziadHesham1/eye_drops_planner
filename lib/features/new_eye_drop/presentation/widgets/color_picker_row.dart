import 'dart:math';

import 'package:bill_planner/common/app_colors.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorPickerRow extends StatefulWidget {
  final Function(Color color) onValueChanged;
  final Function(Color color) onInitial;

  const ColorPickerRow({
    super.key,
    required this.onValueChanged,
    required this.onInitial,
  });

  @override
  State<ColorPickerRow> createState() => _ColorPickerRowState();
}

class _ColorPickerRowState extends State<ColorPickerRow> {
  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    selectedIndex = Random().nextInt(AppColors.scheduleColorsList.length);
    widget.onInitial(AppColors.scheduleColorsList[selectedIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Color',
          style: TextStyle(
            color: AppColors.grey500,
          ),
        ),
        SizedBox(height: 6.h),
        Row(
          children: AppColors.scheduleColorsList.asMap().entries.map((entry) {
            return Row(
              children: [
                ColorIndicator(
                  onSelect: () {
                    setState(() {
                      selectedIndex = entry.key;
                      widget.onValueChanged(
                          AppColors.scheduleColorsList[entry.key]);
                    });
                  },
                  isSelected: selectedIndex == entry.key,
                  color: entry.value,
                  width: 20.w,
                  height: 20.h,
                ),
                SizedBox(width: 8.w),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
