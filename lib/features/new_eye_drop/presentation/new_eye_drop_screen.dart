import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/app_colors.dart';
import '../../../common/widgets/app_checkbox.dart';
import '../../../common/widgets/buttons/app_elevated_button.dart';
import '../../../common/widgets/fields/app_text_field.dart';
import '../../../common/widgets/num_picker.dart';
import '../logic/eye_drop_cubit.dart';
import 'widgets/color_picker_row.dart';
import 'widgets/form_action_button.dart';
import 'widgets/treatment_duration_section_widget.dart';

class NewEyeDropScreen extends StatefulWidget {
  const NewEyeDropScreen({super.key});

  @override
  State<NewEyeDropScreen> createState() => _NewEyeDropScreenState();
}

class _NewEyeDropScreenState extends State<NewEyeDropScreen> {
  final _formKey = GlobalKey<FormState>();

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      context.read<EyeDropsCubit>().onCreateNewEyeDrop();
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Eye Drop'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _nameField(),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ColorPickerRow(
                      onValueChanged: onSelectedColor,
                      onInitial: onSelectedColor,
                    ),
                    SizedBox(
                      height: 20.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: AppCheckbox(
                          initialValue: true,
                          label: 'Active',
                          onValueChanged: onActiveChanged,
                          onInitial: onActiveChanged,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                const Text(
                  'Required data',
                  style: TextStyle(
                    color: AppColors.grey500,
                  ),
                ),
                const TreatmentDurationSectionWidget(),
                const FormActionButton(
                  icon: Icons.timer,
                  label: 'How often do you take it?',
                ),
                NumPicker(
                  initialValue: 3,
                  onValueChanged: onRepetitionsChanged,
                  onInitial: onRepetitionsChanged,
                  minValue: 1,
                  maxValue: 12,
                  step: 1,
                  itemHeight: 50.h,
                  bottomText: 'Drop(s)',
                ),
                SizedBox(height: 10.h),
                AppElevatedButton(
                  onPressed: _handleSubmit,
                  label: 'Submit',
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppTextField _nameField() {
    final int itemsCount =
        context.read<EyeDropsCubit>().state.eyeDropsListModel.items.length;
    var initialName = 'My Eye Drop ${itemsCount + 1}';
    return AppTextField(
      labelText: 'Eye Drop Name',
      initialValue: initialName,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        context.read<EyeDropsCubit>().onUpdateNewEyeDrop(name: value);
      },
      validator: (value) =>
          value?.isEmpty == true ? 'Please enter a name' : null,
    );
  }

  void onSelectedColor(color) {
    context.read<EyeDropsCubit>().onUpdateNewEyeDrop(color: color);
  }

  onRepetitionsChanged(number) {
    log('new_eye_drop_screen > ' 'picked number: $number');
    context.read<EyeDropsCubit>().onUpdateNewEyeDrop(repetitions: number);
  }

  onActiveChanged(bool active) {
    context.read<EyeDropsCubit>().onUpdateNewEyeDrop(disabled: !active);
  }
}
