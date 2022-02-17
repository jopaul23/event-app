import 'package:event_creation/view/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({Key? key, required this.onpressed, required this.text})
      : super(key: key);
  final String text;
  final VoidCallback onpressed;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onpressed,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 4 * defaultPadding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryBlue,
          borderRadius: BorderRadius.circular(25),
        ),
        child: loading
            ? const SpinKitFadingCircle(
                size: 30,
                color: white,
              )
            : Text(
                widget.text,
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
