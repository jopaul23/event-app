import 'package:event_creation/view/constants/constants.dart';
import 'package:event_creation/view/screens/addEvent/event_form.dart';
import 'package:event_creation/view/screens/addEvent/time_control_widget.dart';
import 'package:event_creation/view/widgets/buttons/rounded_rect_btns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          leadingWidth: defaultPadding,
          title: Text(
            "Add Event",
            style: TextStyle(
              color: primaryBlue,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: SvgPicture.asset("assets/svg/signup.svg")),
              const SizedBox(
                height: defaultPadding,
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Starting time",
                      style: TextStyle(
                        color: textColor1,
                        fontSize: 16.sp,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TimeContainer(),
                  ],
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              EventForm(size: MediaQuery.of(context).size),
              const SizedBox(
                height: defaultPadding,
              ),
              PrimaryButton(
                  onpressed: () {
                    print("pressed");
                  },
                  text: "create event")
            ]),
          ),
        ),
      ),
    );
  }
}
