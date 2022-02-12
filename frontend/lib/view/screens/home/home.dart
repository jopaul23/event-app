import 'package:event_creation/api/event_api.dart';
import 'package:event_creation/controllers/event_controller.dart';
import 'package:event_creation/models/event.dart';
import 'package:event_creation/view/constants/constants.dart';
import 'package:event_creation/view/widgets/buttons/circle_add_btn.dart';
import 'package:event_creation/view/widgets/buttons/rounded_rect_btns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventController = Get.put(EventController());
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
        floatingActionButton: CircleAddBtn(
          onPressed: (() => print("pressed")),
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
                itemBuilder: (context, index) => Column(
                      children: [
                        if (eventList.length == 1)
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  timeToDDMMYY(eventList[0].startingTime))),
                        if (index > 0)
                          eventList[index].startingTime.day !=
                                  eventList[index - 1].startingTime.day
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: defaultPadding),
                                  child: Text(timeToDDMMYY(
                                      eventList[index].startingTime)),
                                )
                              : const SizedBox(),
                        Container(
                          margin: const EdgeInsets.only(top: defaultPadding),
                          padding: const EdgeInsets.all(8),
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: textColor1.withOpacity(.1),
                                  blurRadius: 20,
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/event.svg",
                                color: primaryBlue,
                                height: 40,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    eventList[index].name,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${timeToHM(eventList[index].startingTime)} - ${timeToHM(eventList[index].endingTime)}",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ));
          }),
        ),
      ),
    );
  }

  String timeToHM(DateTime time) {
    int min = time.minute;
    if (min < 10) return "${time.hour}:0${time.minute}";
    return "${time.hour}:${time.minute}";
  }

  String timeToDDMMYY(DateTime time) {
    return "${time.day}/${time.month}/${time.year}";
  }
}
