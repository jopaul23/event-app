import 'package:admin_dashboard/controllers/user_controller.dart';
import 'package:admin_dashboard/models/user_model.dart';
import 'package:admin_dashboard/views/constants/constants.dart';
import 'package:admin_dashboard/views/screens/users/user_container.dart';
import 'package:admin_dashboard/views/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    userController.getUsers();
    int _currentIndex = 0;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:
            BottomNavigationBarCustom(currentIndex: _currentIndex),
        body: Container(
          color: bgColor,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Users",
                    style: TextStyle(
                        color: primaryBlue,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              GetBuilder<UserController>(builder: (context) {
                List<UserModel> users = userController.userList;
                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 8.0,
                    children: List.generate(users.length, (index) {
                      return Center(
                          child: UserContainer(
                              size: size,
                              user: users[index],
                              onPressed: () {
                                print("pressed user");
                              }));
                    }),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
