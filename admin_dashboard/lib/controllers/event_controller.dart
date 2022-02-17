import 'package:admin_dashboard/api/event_api.dart';
import 'package:admin_dashboard/models/event_model.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  List<Event> eventList = [];
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
