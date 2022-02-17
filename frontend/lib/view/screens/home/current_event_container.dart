import 'package:event_creation/controllers/event_add_controller.dart';
import 'package:event_creation/controllers/event_controller.dart';
import 'package:event_creation/view/constants/constants.dart';
import 'package:event_creation/view/screens/home/endEventOverlay/end_event_overlay.dart';
import 'package:event_creation/view/widgets/buttons/square_btn.dart';
import 'package:event_creation/view/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

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
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: textColor1.withOpacity(.1),
              blurRadius: 20,
            )
          ]),
      child: GetBuilder<EventAddController>(builder: (context) {
        return Column(
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
            Row(
              children: [
                SvgPicture.asset("assets/svg/clock.svg"),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Started at ${EventController.timeToHM(eventAddController.startingTime)}",
                  style: TextStyle(
                    color: primaryBlue,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/svg/school.svg"),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    eventAddController.school,
                    style: TextStyle(
                      color: primaryBlue,
                      fontSize: 14.sp,
                    ),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/svg/location.svg"),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    eventAddController.geoStartingCodedLocation
                        .replaceAll("}", ""),
                    maxLines: 5,
                    style: TextStyle(
                      color: primaryBlue,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SquareButton(
                  width: 200,
                  color: green,
                  text: "Mark as Completed",
                  onPressed: () async {
                    eventAddController.endingTime = DateTime.now();
                    late OverlayEntry overlay;
                    overlay = OverlayEntry(
                        builder: (context) =>
                            EndEventOverlay(overlay: overlay));
                    Overlay.of(Get.overlayContext!)?.insert(overlay);
                    Position location =
                        await EventAddController.determinePosition();
                    eventAddController.endingLocation =
                        "${location.latitude},${location.longitude}";

                    eventAddController.endingGeocodedLocation =
                        await EventAddController.geocodeLocation(
                            eventAddController.endingLocation);
                    eventAddController.update();
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
                    eventAddController.reset();
                    showToast(
                        context: Get.overlayContext!,
                        title: "event cancelled successfully",
                        description: "",
                        icon: "assets/svg/tick.svg",
                        color: primaryBlue);
                    eventAddController.update();
                  },
                )
              ],
            )
          ],
        );
      }),
    );
  }
}
