import 'package:event_creation/api/event_api.dart';
import 'package:event_creation/controllers/event_controller.dart';
import 'package:event_creation/main.dart';
import 'package:event_creation/view/constants/constants.dart';
import 'package:event_creation/view/screens/home/event_container.dart';
import 'package:event_creation/view/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventAddController extends GetxController {
  final eventController = Get.find<EventController>();

  bool am = true;
  int minute = 0;
  int hour = 9;
  DateTime dueTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 23, 59, 0, 0, 0);

  String eventName = '';
  String startingLocation = '';
  String endingLocation = '';
  String school = '';
  DateTime? startingTime;
  DateTime? endingTime;
  BuildContext? context;

  void noonSelection() {
    am = !am;
    dueTime = toDateTime(hour, minute, am, dueTime);
    debugPrint(dueTime.toString());
    update();
  }

  DateTime toDateTime(int hr, int min, bool isAm, DateTime date) {
    if (!isAm) {
      if (hr != 12) {
        hr += 6;
      }
    } else {
      if (hr == 12) {
        hr -= 12;
      }
    }
    DateTime newDateTime = DateTime(date.year, date.month, date.day, hr, min,
        date.second, date.millisecond, date.microsecond);
    return newDateTime;
  }

  addEvent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");

    Map<String, dynamic> eventMap = {
      "name": eventName,
      "userEmail": email!,
      "startingTime": startingTime!.toIso8601String(),
      "endingTime": endingTime!.toIso8601String(),
      "startingLocation": startingLocation,
      "endingLocation": endingLocation,
      "school": school
    };

    int status = await EventApi.addEvent(eventMap);
    if (status == 200) {
      eventName = "";
      showToast(
          context: context!,
          title: "successfully added event",
          description: "",
          icon: "assets/svg/tick.svg",
          color: primaryBlue);
    } else {
      print("unexpected error occured");
      showToast(
          context: context!,
          title: "event creation failed",
          description: "",
          icon: "assets/svg/warning.svg",
          color: toastYellow);
    }
    update();
    eventController.getEvents();
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
