import 'dart:convert';

import 'package:event_creation/controllers/event_add_controller.dart';
import 'package:event_creation/controllers/event_controller.dart';
import 'package:event_creation/view/constants/constants.dart';
import 'package:event_creation/view/screens/addEvent/event_form.dart';
import 'package:event_creation/view/screens/addEvent/time_control_widget.dart';
import 'package:event_creation/view/screens/home/home.dart';
import 'package:event_creation/view/widgets/buttons/rounded_rect_btns.dart';
import 'package:event_creation/view/widgets/time_selector_widget.dart';
import 'package:event_creation/view/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final addEventController = Get.find<EventAddController>();
  final eventFormKey = GlobalKey<EventFormState>();
  final timeKey = GlobalKey<TimeControlWidgetState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          leadingWidth: defaultPadding,
          title: Text(
            "Add Event",
            style: TextStyle(
              color: primaryBlue,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: SvgPicture.asset("assets/svg/signup.svg")),
              const SizedBox(
                height: defaultPadding,
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Starting time",
                      style: TextStyle(
                        color: textColor1,
                        fontSize: 16.sp,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TimeControlWidget(
                      key: timeKey,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              EventForm(key: eventFormKey, size: MediaQuery.of(context).size),
              const SizedBox(
                height: defaultPadding,
              ),
              Center(
                child: PrimaryButton(
                  onpressed: () {
                    addEventController.eventName = eventFormKey
                        .currentState!.eventKey.currentState!.myController.text;
                    addEventController.school = eventFormKey.currentState!
                        .schoolKey.currentState!.myController.text;
                    bool am = timeKey.currentState!.isAm;
                    int hr = int.parse(
                        timeKey.currentState!.hourTimeController.text);
                    int min =
                        int.parse(timeKey.currentState!.minTimeController.text);
                    addEventController.startingTime =
                        addEventController.toDateTime(
                            hr, min, am, addEventController.startingTime);

                    if (DateTime.now()
                        .isAfter(addEventController.startingTime)) {
                      showToast(
                        context: context,
                        title: "time should be after current time",
                        description: "",
                        icon: "assets/svg/warning.svg",
                        color: toastYellow,
                      );
                    } else if (addEventController.eventName == "" ||
                        addEventController.school == "") {
                      showToast(
                        context: context,
                        title: "all fields are required",
                        description: "",
                        icon: "assets/svg/warning.svg",
                        color: toastYellow,
                      );
                    } else {
                      showToast(
                          context: context,
                          title: "event created successfully",
                          description: "",
                          icon: "assets/svg/tick.svg",
                          color: primaryBlue);

                      EventAddController.determinePosition()
                          .then((Position location) async {
                        addEventController.startingLocation =
                            "${location.latitude},${location.longitude}";
                        addEventController.geoStartingCodedLocation =
                            await EventAddController.geocodeLocation(
                                addEventController.startingLocation);
                        print(
                            "----------------geocoded location---------------");
                        print(addEventController.geoStartingCodedLocation);
                        print(
                            "-------------end geocoded location---------------");
                        addEventController.addEvent();
                        addEventController.update();
                      });

                      Get.off(const Home());
                    }
                  },
                  text: "create event",
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
