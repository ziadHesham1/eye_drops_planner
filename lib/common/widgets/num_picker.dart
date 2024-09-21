import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:numberpicker/numberpicker.dart';

import '../app_colors.dart';

class NumPicker extends StatefulWidget {
  final String? topText;
  final String bottomText;
  final int initialValue;
  final ValueChanged<int> onValueChanged;
  final Function(int) onInitial;
  final int minValue;
  final int maxValue;
  final int step;
  final double? itemHeight;
  NumPicker({
    super.key,
    required this.initialValue,
    required this.onValueChanged,
    required this.minValue,
    required this.maxValue,
    required this.step,
    this.topText,
    required this.bottomText,
    this.itemHeight,
    required this.onInitial,
  }) {
    onValueChanged(initialValue);
  }

  @override
  State<NumPicker> createState() => _NumPickerState();
}

class _NumPickerState extends State<NumPicker> {
  int? currentValue;
  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
    widget.onInitial(currentValue ?? 1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.topText != null)
            Text(
              widget.topText!,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          NumberPicker(
            textStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black.withOpacity(0.3),
            ),
            selectedTextStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            value: currentValue ?? widget.initialValue,
            minValue: widget.minValue,
            maxValue: widget.maxValue,
            step: widget.step,
            itemHeight: widget.itemHeight ?? 100.h,
            itemWidth: 70.w,
            itemCount: 5,
            axis: Axis.horizontal,
            onChanged: (value) {
              log('num_picker > ' 'picked number: $value');
              setState(() {
                currentValue = value;
                widget.onValueChanged(value);
              });
            },
          ),
          Text(
            widget.bottomText,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
