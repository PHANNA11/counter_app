import 'package:counter_app/database/migration.dart';
import 'package:counter_app/user/model/user_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:sqflite/sqlite_api.dart';

class ListUserController extends GetxController
    with StateMixin<List<UserModel>> {
  RxList<UserModel> listUsers = <UserModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getUser();
  }

  void addUser({required UserModel user}) async {
    await DatabaseConnection().insertUser(user: user);
    getUser();
    update();
  }

  void getUser() async {
    await DatabaseConnection()
        .getUserList()
        .then((value) => listUsers.assignAll(value));
    update();
  }
}
