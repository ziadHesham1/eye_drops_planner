import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app_colors.dart';

class AppTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final double? width;
  final String? initialValue;
  final int maxLines;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final Function()? onTap;
  final Function(String?)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final bool isObscureText;
  final bool hasBorder;
  final bool isRequired;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? enabled;

  const AppTextField({
    super.key,
    this.labelText,
    this.width,
    this.onSaved,
    this.validator,
    this.isObscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.initialValue,
    this.maxLines = 1,
    this.controller,
    this.prefixIcon,
    this.hasBorder = true,
    this.onFieldSubmitted,
    this.textInputAction,
    this.focusNode,
    this.textAlign,
    this.onEditingComplete,
    this.textDirection,
    this.enabled,
    this.onTap,
    this.hintText,
    this.isRequired = true,
    this.onChanged,
    this.onSubmit,
  });

  OutlineInputBorder buildBorder({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color ?? Colors.transparent,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(16.r),
    );
  }

  OutlineInputBorder buildErrorBorder({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color ?? AppColors.red,
        width: 0.5,
      ),
      gapPadding: 14,
      borderRadius: BorderRadius.circular(16.r),
    );
  }

  InputDecoration decoration() {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: AppColors.grey50,
      focusColor: AppColors.white,
      alignLabelWithHint: true,
      prefixIcon: prefixIcon,
      prefixIconColor: AppColors.primary,
      errorMaxLines: 5,
      contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 14.h),
      suffixIcon: suffixIcon,
      suffixIconColor: AppColors.primary,
      border: hasBorder ? buildBorder() : null,
      enabledBorder: hasBorder ? buildBorder() : null,
      focusedBorder: hasBorder ? buildBorder() : null,
      errorBorder: hasBorder ? buildErrorBorder() : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              labelText!,
              style: const TextStyle(
                color: AppColors.grey500,
              ),
            ),
          ),
        SizedBox(
          width: width,
          child: TextFormField(
            selectionHeightStyle: BoxHeightStyle.max,
            onTap: onTap,
            enabled: enabled,
            textDirection: textDirection,
            focusNode: focusNode,
            controller: controller,
            textCapitalization: textCapitalization,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            onFieldSubmitted: onFieldSubmitted,
            keyboardType: keyboardType,
            obscureText: isObscureText,
            onSaved: onSaved,
            validator: validator,
            maxLines: maxLines,
            initialValue: initialValue,
            textInputAction: textInputAction ?? TextInputAction.next,
            decoration: decoration(),
          ),
        ),
      ],
    );
  }
}
