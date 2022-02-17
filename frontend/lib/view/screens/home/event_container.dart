import 'package:event_creation/controllers/event_controller.dart';
import 'package:event_creation/models/event.dart';
import 'package:event_creation/view/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventContainer extends StatelessWidget {
  const EventContainer({
    Key? key,
    required this.eventList,
    required this.index,
  }) : super(key: key);
  final List<Event> eventList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index > 0)
          eventList[index].startingTime.day !=
                  eventList[index - 1].startingTime.day
              ? Padding(
                  padding: const EdgeInsets.only(top: defaultPadding),
                  child: Text(EventController.timeToDDMMYY(
                      eventList[index].startingTime)),
                )
              : const SizedBox(),
        if (index == 0)
          Padding(
            padding: const EdgeInsets.only(top: defaultPadding),
            child:
                Text(EventController.timeToDDMMYY(eventList[0].startingTime)),
          ),
        Container(
          margin: const EdgeInsets.only(top: defaultPadding),
          padding: const EdgeInsets.all(defaultPadding),
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
                    "${EventController.timeToHM(eventList[index].startingTime)} - ${EventController.timeToHM(eventList[index].endingTime)}",
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: Text(
                      eventList[index].school,
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
