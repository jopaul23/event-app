import 'package:event_creation/controllers/event_add_controller.dart';
import 'package:event_creation/view/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TimeControlWidget extends StatefulWidget {
  const TimeControlWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeControlWidget> createState() => TimeControlWidgetState();
}

class TimeControlWidgetState extends State<TimeControlWidget> {
  // EventAddController eventAddController = Get.find<EventAddController>();

  final minTimeController = TextEditingController(text: "00");

  final hourTimeController = TextEditingController(text: "9");
  bool isAm = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventAddController>(builder: (context) {
      return SizedBox(
        width: 200,
        child: Row(
          children: [
            Container(
              height: 55,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: textColor1.withOpacity(0.2),
                    )
                  ]),
              child: Row(children: [
                Container(
                  width: 60,
                  height: 55,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: FocusScope(
                    child: Focus(
                      onFocusChange: (focus) {
                        if (!focus) {
                          _addTime();
                        }
                      },
                      child: TextFormField(
                        controller: hourTimeController,
                        onEditingComplete: () {
                          _addTime();
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        onChanged: (value) {
                          hourTimeValidator(value);
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        textAlign: TextAlign.center,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        style: TextStyle(fontSize: 16.sp, color: textColor1),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  height: 55,
                  decoration: const BoxDecoration(
                      color: Color(0xffF6F6F6),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: FocusScope(
                    child: Focus(
                      onFocusChange: (focus) {
                        if (!focus) {
                          _addTime();
                        }
                      },
                      child: TextFormField(
                        onEditingComplete: () {
                          _addTime();
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        controller: minTimeController,
                        onChanged: (value) {
                          minTimeValidator(value);
                        },
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 16.sp, color: textColor1),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isAm = !isAm;
                  // eventAddController.noonSelection();
                });
              },
              child: SizedBox(
                height: 52,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Am",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isAm ? primaryBlue : hintTextColor),
                    ),
                    Text(
                      "Pm",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: !isAm ? primaryBlue : hintTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  void _addTime() {
    if (minTimeController.text.isEmpty) {
      minTimeController.text = "00";
    }
    if (minTimeController.text.length == 1) {
      minTimeController.text = "0${minTimeController.text}";
    }
    if (hourTimeController.text.isEmpty) {
      hourTimeController.text = "00";
    }

    if (hourTimeController.text.length == 1) {
      hourTimeController.text = "0${hourTimeController.text}";
    }
    // eventAddController.hour = int.parse(hourTimeController.text);
    // eventAddController.minute = int.parse(minTimeController.text);
    // eventAddController.updateTime();
  }

  void minTimeValidator(value) {
    if (!value.isEmpty) {
      if (int.parse(value) > 59 && value.length <= 2) {
        minTimeController.text = "59";
        minTimeController.selection = TextSelection(
            baseOffset: 0, extentOffset: minTimeController.value.text.length);
      } else if (value.length > 2) {
        minTimeController.text = (int.parse(value) / 10).floor().toString();
        minTimeController.selection = TextSelection(
            baseOffset: 0, extentOffset: minTimeController.value.text.length);
      } else if (int.parse(value) < 0) {
        minTimeController.text = "00";
        minTimeController.selection = TextSelection(
            baseOffset: 0, extentOffset: minTimeController.value.text.length);
      }
    }
  }

  void hourTimeValidator(value) {
    if (!value.isEmpty) {
      if (int.parse(value) > 12 && value.length <= 2) {
        hourTimeController.text = "12";
        hourTimeController.selection = TextSelection(
            baseOffset: 0, extentOffset: hourTimeController.value.text.length);
      } else if (value.length > 2) {
        hourTimeController.text = (int.parse(value) / 10).floor().toString();
        hourTimeController.selection = TextSelection(
            baseOffset: 0, extentOffset: hourTimeController.value.text.length);
      } else if (int.parse(value) < 0) {
        hourTimeController.text = "00";
        hourTimeController.selection = TextSelection(
            baseOffset: 0, extentOffset: hourTimeController.value.text.length);
      }
    }
  }
}
