import 'package:event_creation/controllers/event_add_controller.dart';
import 'package:event_creation/controllers/event_controller.dart';
import 'package:event_creation/models/event.dart';
import 'package:event_creation/view/constants/constants.dart';
import 'package:event_creation/view/screens/home/add_event_overlay.dart';
import 'package:event_creation/view/screens/home/current_event_container.dart';
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
    _showOverLay() {
      late OverlayEntry addEventOverlay;
      addEventOverlay = OverlayEntry(
          builder: (context) => AddEventOverlay(overlay: addEventOverlay));

      Overlay.of(context)?.insert(addEventOverlay);
    }

    final eventController = Get.put(EventController());
    final eventAddController = Get.put(EventAddController());
    eventAddController.context = context;
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
        floatingActionButton:
            GetBuilder<EventAddController>(builder: (context) {
          return eventAddController.eventName != ""
              ? const SizedBox()
              : CircleAddBtn(
                  onPressed: _showOverLay,
                );
        }),
        body: Padding(
          padding: const EdgeInsets.only(
              left: defaultPadding,
              bottom: defaultPadding,
              right: defaultPadding),
          child: Column(
            children: [
              GetBuilder<EventAddController>(builder: (context) {
                return eventAddController.eventName != ""
                    ? const CurrentEventContainer()
                    : const SizedBox();
              }),
              const SizedBox(
                height: 10,
              ),
              GetBuilder<EventController>(builder: (context) {
                List<Event> eventList = eventController.eventList;
                return Expanded(
                  child: ListView.builder(
                      itemCount: eventList.length,
                      itemBuilder: (context, index) =>
                          EventContainer(eventList: eventList, index: index)),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
