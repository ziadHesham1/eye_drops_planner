// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:kafiil_test/common/app_assets.dart';

import '../../app_assets.dart';
import 'app_text_field.dart';

class AppDateField extends StatefulWidget {
  final String? initialValue;
  final Function(DateTime date) onTap;
  final String? labelText;
  final String? Function(String?)? validator;

  const AppDateField({
    super.key,
    this.initialValue,
    required this.onTap,
    this.labelText,
    this.validator,
  });

  @override
  State<AppDateField> createState() => _IschoolerDateFieldState();
}

class _IschoolerDateFieldState extends State<AppDateField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: _controller,
      // initialValue: widget.initialValue,
      labelText: widget.labelText,
      validator: widget.validator,
      suffixIcon: Image.asset(AppAssets.calender_icon),
      onTap: () async {
        DateTime date = DateTime(1900);
        FocusScope.of(context).requestFocus(FocusNode());
        date = await showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100)) ??
            DateTime(1900);
        widget.onTap(date);
        // String formattedDate = DateFormat('yyyy-MM-dd').format(now);

        _controller.text = DateFormat('yyyy-MM-dd').format(date).toString();
      },
    );
  }
}
