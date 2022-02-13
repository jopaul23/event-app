import 'dart:convert';

import 'package:event_creation/models/event.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventApi {
  static Future<List<Event>> getEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    String? token = prefs.getString("auth-token");
    Uri uri = Uri.parse("http://159.89.161.168:4051/api/events/get-events");
    List<Event> eventList = [];

    Map<String, dynamic> body = {"userEmail": email!};
    Map<String, String> header = {
      "auth-token": token!,
      "content-type": "application/json"
    };
    http.Response response =
        await http.post(uri, body: json.encode(body), headers: header);
    print("status code ${response.statusCode}");
    if (response.statusCode == 200) {
      print("-------------response body --------------");
      print(response.body);
      for (Map<String, dynamic> event in json.decode(response.body))
        eventList.add(Event.fromMap(event));
      return eventList;
    } else {
      print(response);
      eventList = [];
    }
    return eventList;
  }

  static Future<int> addEvent(Map<String, dynamic> body) async {
    print("-----------------event map----------------");
    print(body);
    print("--------------------end----------------");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth-token");
    Uri uri = Uri.parse("http://159.89.161.168:4051/api/events/post-event");

    Map<String, String> header = {
      "auth-token": token!,
      "content-type": "application/json"
    };
    http.Response response =
        await http.post(uri, body: json.encode(body), headers: header);
    print(response.statusCode);
    return response.statusCode;
  }
}
