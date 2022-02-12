import 'package:event_creation/api/event_api.dart';
import 'package:event_creation/models/event.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  List<Event> eventList = [];
  getEvents() async {
    eventList = await EventApi.getEvents();
    update();
  }
}
