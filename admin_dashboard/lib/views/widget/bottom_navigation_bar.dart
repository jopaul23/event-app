import 'package:admin_dashboard/views/constants/constants.dart';
import 'package:admin_dashboard/views/screens/events/event_page.dart';
import 'package:admin_dashboard/views/screens/users/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({Key? key, required this.currentIndex})
      : super(key: key);
  final int currentIndex;

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    List pages = [const UserPage(), const EventPage()];
    return BottomNavigationBar(
      backgroundColor: white,
      currentIndex: widget.currentIndex,
      onTap: (newIndex) {
        setState(() {
          if (newIndex != widget.currentIndex) {
            Get.to(pages[newIndex]);
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svg/user.svg",
            height: 30,
            color: widget.currentIndex == 0 ? primaryBlue : textColor1,
          ),
          label: "user",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svg/event.svg",
            height: 28,
            color: widget.currentIndex == 1 ? primaryBlue : textColor1,
          ),
          label: "event",
        ),
      ],
    );
  }
}
