import 'package:dio/dio.dart';
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
  DateTime startingTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 9, 0, 0, 0, 0);

  String eventName = '';
  String startingLocation = '';
  String endingLocation = '';
  String school = '';
  // DateTime? startingTime;
  DateTime? endingTime;
  // BuildContext? context;

  String geoStartingCodedLocation = "";
  String endingGeocodedLocation = "";
  reset() {
    am = true;
    minute = 0;
    hour = 9;
    startingTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 9, 0, 0, 0, 0);

    eventName = '';
    startingLocation = '';
    endingLocation = '';
    school = '';
    // DateTime? startingTime;
    // BuildContext? context;

    geoStartingCodedLocation = "";
  }

  void updateTime() {
    startingTime = toDateTime(hour, minute, am, startingTime);
  }

  void noonSelection() {
    am = !am;
    startingTime = toDateTime(hour, minute, am, startingTime);
    debugPrint(startingTime.toString());
    update();
  }

  DateTime toDateTime(int hr, int min, bool isAm, DateTime date) {
    if (!isAm) {
      if (hr != 12) {
        hr += 12;
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
      "startingTime": startingTime.toIso8601String(),
      "endingTime": endingTime!.toIso8601String(),
      "startingLocation": startingLocation,
      "endingLocation": endingLocation,
      "school": school
    };

    int status = await EventApi.addEvent(eventMap);
    if (status == 200) {
      eventName = "";
      showToast(
          context: Get.overlayContext!,
          title: "successfully added event",
          description: "",
          icon: "assets/svg/tick.svg",
          color: primaryBlue);
    } else {
      print("unexpected error occured");
      showToast(
          context: Get.overlayContext!,
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

  static Future<String> geocodeLocation(String location) async {
    String locationName = "";
    List<String> positions = location.split(",");
    try {
      String url =
          "https://nominatim.openstreetmap.org/reverse?format=json&lat=${positions[0]}&lon=${positions[1]}&zoom=18&addressdetails=1";
      final response = await Dio().get(url);
      locationName = "${response.data["display_name"].toString()}}";
      print("---------------response for geocoding--------------");
      print(url);
      print(response.data);
      print("-----------end for response for geocoding--------------");
    } catch (e) {
      print(e);
      locationName = location;
    }
    return locationName;
  }
}
