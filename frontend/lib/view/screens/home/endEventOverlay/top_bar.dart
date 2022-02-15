import 'package:event_creation/controllers/event_add_controller.dart';
import 'package:event_creation/view/screens/home/endEventOverlay/end_event_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/constants.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.addEventController,
    required this.widget,
  }) : super(key: key);

  final EventAddController addEventController;
  final EndEventOverlay widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          addEventController.eventName,
          style: TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => widget.overlay.remove(),
          child: SvgPicture.asset(
            "assets/svg/exit.svg",
            color: red,
            height: 30,
            width: 30,
          ),
        ),
      ],
    );
  }
}
