import 'package:event_creation/controllers/event_add_controller.dart';
import 'package:event_creation/controllers/event_controller.dart';
import 'package:event_creation/view/constants/constants.dart';
import 'package:event_creation/view/widgets/buttons/square_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CurrentEventContainer extends StatefulWidget {
  const CurrentEventContainer({Key? key}) : super(key: key);

  @override
  State<CurrentEventContainer> createState() => _CurrentEventContainerState();
}

class _CurrentEventContainerState extends State<CurrentEventContainer> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final eventAddController = Get.find<EventAddController>();
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      height: 120,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: textColor1.withOpacity(.1),
              blurRadius: 20,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            eventAddController.eventName,
            style: TextStyle(
              color: textColor1,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          Text(
            "Started at ${EventController.timeToHM(eventAddController.startingTime!)}",
            style: TextStyle(
              color: primaryBlue,
              fontSize: 14.sp,
            ),
          ),
          Row(
            children: [
              isLoading
                  ? Container(
                      width: 200,
                      constraints: const BoxConstraints(
                        maxHeight: 40.0,
                      ),
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: green,
                      ),
                      child: const SpinKitRing(
                        lineWidth: 5,
                        color: Colors.white,
                        // size: 50.0,
                      ),
                    )
                  : SquareButton(
                      width: 200,
                      color: green,
                      text: "Mark as Completed",
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        eventAddController.endingTime = DateTime.now();
                        Position location =
                            await EventAddController.determinePosition();
                        eventAddController.endingLocation =
                            "${location.latitude},${location.longitude}";
                        eventAddController.addEvent();
                      },
                    ),
              const SizedBox(
                width: 10,
              ),
              SquareButton(
                width: 70,
                color: red,
                text: "cancel",
                onPressed: () {
                  eventAddController.eventName = "";
                  eventAddController.startingLocation = "";
                  eventAddController.update();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
