import 'package:admin_dashboard/api/user_api.dart';
import 'package:admin_dashboard/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  List<UserModel> userList = [];
  getUsers() async {
    List<UserModel> result = await UserApi.getUsers();
    userList = result;
    update();
  }
}
