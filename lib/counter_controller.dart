import 'dart:developer';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterController extends GetxController with StateMixin {
  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

  RxInt number = 0.obs;
  void increment() {
    number.value++;
    setData();
    update();
  }

  void decrement() {
    number.value--;
    setData();
    update();
  }

  void setData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('number', number.value);
    getData();
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    number.value = prefs.getInt('number') ?? 0;
    log(number.value.toString());
    update();
  }

  void setList() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('names', ['Kim', 'Dany', 'Thin']);
    var listName = prefs.getStringList('names') ?? [];
    listName.addAll(['Dalin', 'Raksmey']);
    prefs.setStringList('names', listName);
  }
}
