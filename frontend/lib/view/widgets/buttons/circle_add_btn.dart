import 'package:event_creation/view/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircleAddBtn extends StatelessWidget {
  const CircleAddBtn({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: primaryBlue, borderRadius: BorderRadius.circular(30)),
        child: const Icon(
          Icons.add_rounded,
          size: 40,
          color: white,
        ),
      ),
    );
  }
}
