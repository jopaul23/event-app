import 'package:event_creation/controllers/event_add_controller.dart';
import 'package:event_creation/view/constants/constants.dart';
import 'package:event_creation/view/widgets/time_selector_widget.dart';
import 'package:event_creation/view/screens/home/endEventOverlay/top_bar.dart';
import 'package:event_creation/view/widgets/buttons/square_btn.dart';
import 'package:event_creation/view/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EndEventOverlay extends StatefulWidget {
  final OverlayEntry overlay;
  const EndEventOverlay({Key? key, required this.overlay}) : super(key: key);

  @override
  State<EndEventOverlay> createState() => _EndEventOverlayState();
}

class _EndEventOverlayState extends State<EndEventOverlay> {
  final nameController = TextEditingController();
  final addEventController = Get.find<EventAddController>();
  final timeKey = GlobalKey<TimeControlWidgetState>();
  @override
  Widget build(BuildContext context) {
    String text = "";
    return Positioned(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.black.withOpacity(.1),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => widget.overlay.remove(),
              child: Container(
                color: Colors.black.withOpacity(.4),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
              ),
            ),
            Center(
              child: Container(
                  height: 370,
                  width: MediaQuery.of(context).size.width - defaultPadding * 4,
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopBar(
                          addEventController: addEventController,
                          widget: widget),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Text(
                        "Ending Time",
                        style: TextStyle(fontSize: 14.sp, color: textColor1),
                      ),
                      SizedBox(
                        height: 80,
                        child: TimeControlWidget(
                          key: timeKey,
                        ),
                      ),
                      Text(
                        "Current location",
                        style: TextStyle(fontSize: 14.sp, color: textColor1),
                      ),
                      GetBuilder<EventAddController>(builder: (context) {
                        return SizedBox(
                          width: 200,
                          child: Text(
                            addEventController.endingGeocodedLocation
                                .replaceAll("}", ""),
                            maxLines: 5,
                            style: TextStyle(
                              color: primaryBlue,
                              fontSize: 14.sp,
                            ),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Center(
                        child: SquareButton(
                            onPressed: () {
                              bool am = timeKey.currentState!.isAm;
                              int hr = int.parse(timeKey
                                  .currentState!.hourTimeController.text);
                              int min = int.parse(
                                  timeKey.currentState!.minTimeController.text);
                              addEventController.endingTime =
                                  addEventController.toDateTime(hr, min, am,
                                      addEventController.endingTime);

                              print(addEventController.endingTime);
                              if (addEventController.endingTime
                                  .isAfter(DateTime.now())) {
                                showToast(
                                  context: context,
                                  title:
                                      "ending time should not exceed current time",
                                  description: "",
                                  icon: "assets/svg/warning.svg",
                                  color: toastYellow,
                                );
                              } else if (addEventController.endingTime
                                  .isBefore(addEventController.startingTime)) {
                                showToast(
                                  context: context,
                                  title:
                                      "ending time should be after starting time",
                                  description: "",
                                  icon: "assets/svg/warning.svg",
                                  color: toastYellow,
                                );
                              } else {
                                addEventController.addEvent();
                                widget.overlay.remove();
                              }
                            },
                            text: "add",
                            color: primaryBlue,
                            width: double.infinity),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
