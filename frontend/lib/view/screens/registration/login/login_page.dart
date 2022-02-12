import 'package:event_creation/api/register_api.dart';
import 'package:event_creation/view/constants/constants.dart';
import 'package:event_creation/view/screens/home/home.dart';
import 'package:event_creation/view/screens/registration/login/login_form.dart';
import 'package:event_creation/view/screens/registration/signup/signup_paage.dart';
import 'package:event_creation/view/widgets/buttons/rounded_rect_btns.dart';
import 'package:event_creation/view/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  bool isLoading = false;
  final formKey = GlobalKey<LoginFormState>();
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            height: size.height - defaultPadding * 2,
            width: size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    "assets/svg/login.svg",
                    height: size.height * 2 / 10,
                  ),
                  SizedBox(
                    child: Column(
                      children: const [
                        Text(
                          "login",
                          style: TextStyle(
                            fontSize: 19,
                            color: textColor1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "all fields arre required",
                          style: TextStyle(
                            fontSize: 10,
                            color: textColor1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  LoginForm(
                    key: formKey,
                    size: size,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  isLoading
                      ? Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width -
                              4 * defaultPadding,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const SpinKitFadingCircle(
                            color: white,
                            size: 30,
                          ))
                      : PrimaryButton(
                          onpressed: () {
                            print("pressed");
                            String email = formKey
                                .currentState!.emailKey.currentState!.text;
                            String password = formKey
                                .currentState!.passwordKey.currentState!.text;
                            if (email == '' || password == '') {
                              showToast(
                                  context: context,
                                  title: "all fields are required",
                                  description: "",
                                  icon: "assets/svg/warning.svg",
                                  color: toastYellow);
                            } else {
                              RegisterApi.login(
                                      email: email, password: password)
                                  .then((result) {
                                if (result["status"] == 200) {
                                  showToast(
                                      context: context,
                                      title: result["message"].toString(),
                                      description: "",
                                      icon: "assets/svg/tick.svg",
                                      color: primaryBlue);
                                  Get.off(() => const Home());
                                } else if (result["status"] == 400) {
                                  showToast(
                                      context: context,
                                      title: result["message"].toString(),
                                      description: "",
                                      icon: "assets/svg/warning.svg",
                                      color: toastYellow);
                                } else {
                                  showToast(
                                      context: context,
                                      title: "unexpected error occured",
                                      description: "",
                                      icon: "assets/svg/warning.svg",
                                      color: toastYellow);
                                }
                              });
                            }
                            print("email $email\npassword $password");
                          },
                          text: "login"),
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "already have an account?",
                          style: TextStyle(fontSize: 10.sp),
                        ),
                        SecondaryBtn(
                            onpressed: () => Get.off(() => const SignupPage()),
                            text: "sign up"),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
