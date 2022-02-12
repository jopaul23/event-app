import 'dart:convert';

import 'package:event_creation/models/event.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventApi {
  static Future<List<Event>> getEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    String? token = prefs.getString("auth-token");
    Uri uri = Uri.parse("http://192.168.56.1:4051/api/events/get-events");
    late List<Event> eventList;

    Map<String, dynamic> body = {"userEmail": email!};
    Map<String, String> header = {"auth-token": token!};
    http.Response response = await http.post(uri, body: body, headers: header);
    print("status code ${response.statusCode}");
    if (response.statusCode == 200) {
      print("-------------response body --------------");
      print(response.body);
      eventList = [Event.fromMap(json.decode(response.body)[0])];
    } else {
      eventList = [];
    }
    return eventList;
  }
}
