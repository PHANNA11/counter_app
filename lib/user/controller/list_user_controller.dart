import 'package:counter_app/user/model/user_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class ListUserController extends GetxController {
  RxList<UserModel> listUsers = <UserModel>[].obs;

  void addUser({required UserModel user}) {
    listUsers.add(user);
    update();
  }
}
