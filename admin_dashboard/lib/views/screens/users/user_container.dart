import 'package:admin_dashboard/models/user_model.dart';
import 'package:admin_dashboard/views/constants/constants.dart';
import 'package:flutter/material.dart';

class UserContainer extends StatefulWidget {
  const UserContainer({
    Key? key,
    required this.size,
    required this.user,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Size size;
  final UserModel user;

  @override
  State<UserContainer> createState() => _UserContainerState();
}

class _UserContainerState extends State<UserContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: widget.size.width / 3.6,
        width: widget.size.width / 3.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: white,
            boxShadow: [
              BoxShadow(blurRadius: 9, color: primaryBlue.withOpacity(.15))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: widget.size.width / 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.user.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: textColor1,
                      fontSize: 13,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    widget.user.email,
                    style: const TextStyle(
                      color: textColor1,
                      decoration: TextDecoration.none,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: widget.size.width / 3.6 - 50,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xff4C8E41),
                  borderRadius: BorderRadius.circular(2)),
            ),
          ],
        ),
      ),
    );
  }
}
