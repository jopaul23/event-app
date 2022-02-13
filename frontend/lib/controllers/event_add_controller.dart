import 'package:event_creation/api/event_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventAddController extends GetxController {
  String eventName = '';
  String startingLocation = '';
  String endingLocation = '';
  DateTime? startingTime;
  DateTime? endingTime;
  addEvent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");

    Map<String, dynamic> eventMap = {
      "name": eventName,
      "userEmail": email!,
      "startingTime": startingTime!.toIso8601String(),
      "endingTime": endingTime!.toIso8601String(),
      "startingLocation": startingLocation,
      "endingLocation": endingLocation
    };

    int status = await EventApi.addEvent(eventMap);
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
