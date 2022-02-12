import 'package:event_creation/api/register_api.dart';
import 'package:event_creation/view/constants/constants.dart';
import 'package:event_creation/view/screens/home/home.dart';
import 'package:event_creation/view/screens/registration/login/login_page.dart';
import 'package:event_creation/view/screens/registration/signup/signup_form.dart';
import 'package:event_creation/view/widgets/buttons/rounded_rect_btns.dart';
import 'package:event_creation/view/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  bool isLoading = false;
  final formKey = GlobalKey<SignupFormState>();

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
                    "assets/svg/signup.svg",
                    height: size.height * 2 / 10,
                  ),
                  SizedBox(
                    child: Column(
                      children: const [
                        Text(
                          "signup",
                          style: TextStyle(
                            fontSize: 19,
                            color: textColor1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Enter your email and password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: textColor1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SignupForm(
                    size: size,
                    key: formKey,
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
                            String name = formKey
                                .currentState!.nameKey.currentState!.text;

                            if (name == '' || email == '' || password == '') {
                              showToast(
                                  context: context,
                                  title: "all field required",
                                  description: "",
                                  icon: "assets/svg/warning.svg",
                                  color: toastYellow);
                            } else {
                              RegisterApi.register(
                                      email: email,
                                      password: password,
                                      name: name)
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
                          },
                          text: "Signup"),
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "dont have an account?",
                          style: TextStyle(fontSize: 10.sp),
                        ),
                        SecondaryBtn(
                            onpressed: () => Get.off(() => const SigninPage()),
                            text: "login"),
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
