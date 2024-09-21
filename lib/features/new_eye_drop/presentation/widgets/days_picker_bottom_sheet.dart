import 'package:flutter/material.dart';

import '../../../../common/widgets/buttons/app_elevated_button.dart';
import '../../../../common/widgets/num_picker.dart';

// ignore: must_be_immutable
class DaysPickerBottomSheet extends StatelessWidget {
  DaysPickerBottomSheet({
    super.key,
  });
  int numberPicked = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Text(
                  'Set number of days',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Divider(height: 2),
            ],
          ),
          NumPicker(
            topText: 'for',
            bottomText: 'days',
            minValue: 1,
            maxValue: 30,
            step: 1,
            initialValue: 12,
            onValueChanged: onNumberChanged,
            onInitial: onNumberChanged,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: AppElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(numberPicked);
              },
              label: 'Confirm',
            ),
          ),
        ],
      ),
    );
  }

  void onNumberChanged(value) {
    numberPicked = value;
  }
}
