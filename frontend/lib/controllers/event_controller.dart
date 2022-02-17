import 'package:event_creation/api/event_api.dart';
import 'package:event_creation/models/event.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class EventController extends GetxController {
  List<Event> eventList = [];
  Event? currentEvent;
  getEvents() async {
    eventList = await EventApi.getEvents();
    update();
  }

  static String timeToHM(DateTime time) {
    int min = time.minute;
    if (min < 10) return "${time.hour}:0${time.minute}";
    return "${time.hour}:${time.minute}";
  }

  static String timeToDDMMYY(DateTime time) {
    return "${time.day}/${time.month}/${time.year}";
  }
}
