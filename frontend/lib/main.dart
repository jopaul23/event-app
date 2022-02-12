import 'package:event_creation/view/constants/constants.dart';
import 'package:event_creation/view/screens/registration/login/login_page.dart';
import 'package:event_creation/view/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenUtilInit(
          builder: () => GetMaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  fontFamily: GoogleFonts.rubik(color: textColor1).fontFamily,
                  primarySwatch: Colors.blue,
                ),
                home: const SplashScreen(),
              )),
    );
  }
}
