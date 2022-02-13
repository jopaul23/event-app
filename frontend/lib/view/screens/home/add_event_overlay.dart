import 'package:event_creation/controllers/event_add_controller.dart';
import 'package:event_creation/controllers/event_controller.dart';
import 'package:event_creation/view/constants/constants.dart';
import 'package:event_creation/view/screens/home/event_container.dart';
import 'package:event_creation/view/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEventOverlay extends StatefulWidget {
  final OverlayEntry overlay;
  const AddEventOverlay({Key? key, required this.overlay}) : super(key: key);

  @override
  State<AddEventOverlay> createState() => _AddEventOverlayState();
}

class _AddEventOverlayState extends State<AddEventOverlay> {
  final nameController = TextEditingController();
  final addEventController = Get.find<EventAddController>();
  @override
  Widget build(BuildContext context) {
    String text = "";
    return Positioned(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.black.withOpacity(.1),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => widget.overlay.remove(),
              child: Container(
                color: Colors.black.withOpacity(.4),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
              ),
            ),
            Center(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width - defaultPadding * 4,
                padding: const EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: white),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => widget.overlay.remove(),
                          child: SvgPicture.asset(
                            "assets/svg/exit.svg",
                            color: red,
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: textColor1.withOpacity(.1),
                                blurRadius: 20,
                              )
                            ]),
                        child: TextFormField(
                          controller: nameController,
                          //validator: widget.validateFun!,
                          // onChanged: (value) =>  = nameController.text,
                          decoration: InputDecoration(
                            hintText: "Event name",
                            hintStyle: TextStyle(fontSize: 16.sp),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          print("pressed");
                          addEventController.eventName = nameController.text;
                          addEventController.startingTime = DateTime.now();
                          EventAddController.determinePosition()
                              .then((Position location) {
                            addEventController.startingLocation =
                                "${location.latitude},${location.longitude}";
                            addEventController.update();
                          });
                          showToast(
                              context: context,
                              title: "successfully created evnet",
                              description: "",
                              icon: "assets/svg/tick.svg",
                              color: primaryBlue);
                          widget.overlay.remove();
                        },
                        child: Container(
                          height: 40,
                          width: 120,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryBlue,
                          ),
                          child: Text(
                            "Add Event",
                            style: GoogleFonts.rubik(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
