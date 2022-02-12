import 'package:event_creation/view/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("pressed");
      },
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 5.0,
          minWidth: 5.0,
          maxHeight: 30.0,
          maxWidth: 30.0,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: green,
        ),
        child: Text(
          "Add Event",
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
