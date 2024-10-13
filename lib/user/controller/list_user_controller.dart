import 'package:counter_app/database/database_conn.dart';
import 'package:counter_app/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:sqflite/sqlite_api.dart';

class ListUserController extends GetxController
    with StateMixin<List<UserModel>> {
  RxList<UserModel> listUsers = <UserModel>[].obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  initUserControl({required UserModel user}) async {
    nameController.text = user.name!;
    salaryController.text = user.salary!.toString();
    positionController.text = user.position!;
    expController.text = user.experience!;
    ageController.text = user.age.toString();
  }

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

  void getFilterUser({required String? search}) async {
    await DatabaseConnection()
        .getSearchUser(search: search)
        .then((value) => listUsers.assignAll(value));
    update();
  }

  Future<bool> deleteUser({required int id}) async {
    await DatabaseConnection().deleteUser(id: id).whenComplete(() {
      getUser();
    });
    return true;
  }

  Future<bool> updateUser({required int id}) async {
    var user = UserModel(
        id: id,
        name: nameController.text,
        age: int.parse(ageController.text),
        experience: expController.text,
        position: positionController.text,
        salary: double.parse(salaryController.text));
    await DatabaseConnection().updateUser(user: user).whenComplete(() {
      getUser();
    });
    return true;
  }

  void searchUer({String? search}) async {
    if (search!.isEmpty) {
      getUser();
    } else {
      getFilterUser(search: search);
    }
  }

  void sortUserBy({int? sort = 0}) async {
    // if (search!.isEmpty) {
    await DatabaseConnection()
        .getSortUser(sort: sort)
        .then((value) => listUsers.assignAll(value));
    update();
    // } else {
    //   getFilterUser(search: search);
    // }
  }
}
