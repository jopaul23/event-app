import 'package:admin_dashboard/controllers/event_controller.dart';
import 'package:admin_dashboard/models/event_model.dart';
import 'package:admin_dashboard/views/constants/constants.dart';
import 'package:admin_dashboard/views/screens/events/event_container.dart';
import 'package:admin_dashboard/views/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  EventController eventController = Get.put(EventController());
  @override
  Widget build(BuildContext context) {
    eventController.getEvents();
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: const BottomNavigationBarCustom(currentIndex: 1),
      backgroundColor: bgColor,
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        height: double.infinity,
        child: GetBuilder<EventController>(builder: (context) {
          List<Event> eventList = eventController.eventList;
          return SingleChildScrollView(
            child: Column(children: [
              for (int i = 0; i < eventList.length; i++)
                EventContainer(eventList: eventList, index: i)
            ]),
          );
        }),
      ),
    ));
  }
}
