// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bill_planner/common/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_text_field.dart';

class AppPasswordField extends StatefulWidget {
  final Function(String?)? onSaved;
  final String labelText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final bool filled;
  const AppPasswordField({
    super.key,
    this.onSaved,
    required this.labelText,
    this.validator,
    this.initialValue,
    this.focusNode,
    this.filled = false,
    this.controller,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool isHiddenPass = true;

  void _togglePass() {
    setState(() {
      isHiddenPass = !isHiddenPass;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      // filled: widget.filled,
      controller: widget.controller,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      focusNode: widget.focusNode,
      initialValue: widget.initialValue,
      labelText: widget.labelText,
      validator: widget.validator,
      textInputAction: TextInputAction.done,
      isObscureText: isHiddenPass,
      suffixIcon: InkWell(
        onTap: _togglePass,
        focusNode: widget.focusNode,
        child: isHiddenPass
            ? const Icon(
                Icons.visibility_off,
                color: AppColors.grey400,
                // size: Constants._screen_height / 35,
              )
            : const Icon(
                Icons.visibility,
                color: AppColors.grey400,

                // size: Constants._screen_height / 35,
              ),
      ),
      // validator: Validations().passwordValidator,
      onSaved: widget.onSaved,
    );
  }
}
