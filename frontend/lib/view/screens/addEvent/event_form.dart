import 'package:event_creation/view/constants/constants.dart';
import 'package:event_creation/view/widgets/textfield_custom.dart';
import 'package:flutter/material.dart';

class EventForm extends StatefulWidget {
  const EventForm({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<EventForm> createState() => EventFormState();
}

class EventFormState extends State<EventForm> {
  final eventKey = GlobalKey<TextFieldCustomState>();
  final schoolKey = GlobalKey<TextFieldCustomState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: widget.size.width - defaultPadding * 2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(defaultPadding),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ]),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              height: 60,
              width: widget.size.width - defaultPadding * 2,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(defaultPadding),
                    topRight: Radius.circular(defaultPadding)),
              ),
              child: TextFieldCustom(
                key: eventKey,
                underline: false,
                isPass: false,
                prefixSvg: "assets/svg/event.svg",
                padding: defaultPadding,
                hintText: "event",
                width: widget.size.width - defaultPadding * 2,
              )),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              height: 60,
              width: widget.size.width - defaultPadding * 2,
              decoration: const BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(defaultPadding),
                    bottomRight: Radius.circular(defaultPadding)),
              ),
              child: TextFieldCustom(
                isPass: false,
                key: schoolKey,
                underline: false,
                prefixSvg: "assets/svg/school.svg",
                padding: defaultPadding,
                hintText: "school",
                width: widget.size.width - defaultPadding * 2,
              )),
        ],
      ),
    );
  }
}
