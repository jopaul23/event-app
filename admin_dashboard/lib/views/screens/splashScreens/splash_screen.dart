import 'package:admin_dashboard/views/constants/constants.dart';
import 'package:admin_dashboard/views/screens/register/login_page.dart';
import 'package:admin_dashboard/views/screens/users/user_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? email;

  @override
  Widget build(BuildContext context) {
    emailCheck();
    return Scaffold(
      backgroundColor: white,
      body: Container(
        alignment: Alignment.center,
        child: const Text("social media"),
      ),
    );
  }

  emailCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email");
    if (email != null) {
      Get.off(() => const UserPage());
      print("email exists");
    } else {
      Get.off(() => const SigninPage());
      print("email donot exist");
    }
  }
}
