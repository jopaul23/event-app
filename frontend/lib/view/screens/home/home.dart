import 'package:event_creation/controllers/event_add_controller.dart';
import 'package:event_creation/controllers/event_controller.dart';
import 'package:event_creation/models/event.dart';
import 'package:event_creation/view/constants/constants.dart';
import 'package:event_creation/view/screens/home/add_event_overlay.dart';
import 'package:event_creation/view/screens/home/event_container.dart';
import 'package:event_creation/view/widgets/buttons/circle_add_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventController = Get.put(EventController());
    final eventAddController = Get.put(EventAddController());
    eventController.getEvents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          leadingWidth: 25,
          title: Text(
            "Event App",
            style: TextStyle(
              color: primaryBlue,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        floatingActionButton: eventAddController.eventName != ""
            ? const SizedBox()
            : CircleAddBtn(
                onPressed: (() {
                  late OverlayEntry addEventOverlay;
                  addEventOverlay = OverlayEntry(
                      builder: (context) =>
                          AddEventOverlay(overlay: addEventOverlay));

                  Overlay.of(context)?.insert(addEventOverlay);
                }),
              ),
        body: Padding(
          padding: const EdgeInsets.only(
              left: defaultPadding,
              bottom: defaultPadding,
              right: defaultPadding),
          child: GetBuilder<EventController>(builder: (context) {
            List<Event> eventList = eventController.eventList;
            return ListView.builder(
                itemCount: eventList.length,
                itemBuilder: (context, index) =>
                    EventContainer(eventList: eventList, index: index));
          }),
        ),
      ),
    );
  }
}
