import 'package:admin_dashboard/views/constants/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key? key, required this.onpressed, required this.text})
      : super(key: key);
  final String text;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 4 * defaultPadding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryBlue,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class SecondaryBtn extends StatelessWidget {
  const SecondaryBtn({Key? key, required this.onpressed, required this.text})
      : super(key: key);
  final String text;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 4 * defaultPadding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              width: 1.5,
              color: primaryBlue,
            )),
        child: Text(
          text,
          style: const TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
