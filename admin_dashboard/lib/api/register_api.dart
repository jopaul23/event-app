import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

class RegisterApi {
  static const url = "http://159.89.161.168:4051";

  static Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    Map req = {
      "email": email,
      "password": password,
    };
    Map<String, dynamic> map = {
      "status": 500,
      "message": "unexpected error occured"
    };
    try {
      // final urLink = Uri.parse(url + "/api/users/login");
      final response = await Dio()
          .post(url + "/api/admin/login", data: jsonEncode(req))
          .catchError((error) {
        print(error.response!.statusCode);
        print(error.response!.data);
        map = {
          "status": error.response!.statusCode,
          "message": error.response!.data["message"] ?? "unexpected error"
        };
      });
      print("status is ${response.statusCode}");

      // Map responseMap = jsonDecode(response.data);
      if (response.statusCode == 200) {
        map = {"status": 200, "message": "login successfull"};
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('auth-token', response.data["token"]);
        prefs.setString('email', response.data["email"]);
        prefs.setString('user_id', response.data["id"]);
        prefs.setString('user_name', response.data["name"]);
      }
    } catch (error) {
      print(error);
    }
    print(map);
    return map;
  }
}
