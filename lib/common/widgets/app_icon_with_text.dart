import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIconWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  const AppIconWithText({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey.shade400,
        ),
        Row(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
                // fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
