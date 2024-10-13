import 'dart:math';

import 'package:counter_app/user/controller/list_user_controller.dart';
import 'package:counter_app/user/model/user_model.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

import '../../database/database_conn.dart';

class ListUserScreen extends StatelessWidget {
  ListUserScreen({super.key});
  final controller = Get.put(ListUserController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListUserController>(builder: (contextGetx) {
      return Scaffold(
        endDrawer: Drawer(
            child: SafeArea(
                child: Column(
          children: [
            const Text(
              'SORT FILTER',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            ListTile(
              onTap: () async {
                //  controller.sortBy = 1;
                controller.sortUserBy(sort: 1);
              },
              title: const Text('DESC'),
            ),
            const Divider(),
            ListTile(
              onTap: () async {
                controller.sortUserBy(sort: 2);
              },
              title: const Text('ESC'),
            )
          ],
        ))),
        appBar: AppBar(
          //  backgroundColor: Colors.blue,
          elevation: 1,
          title: CupertinoSearchTextField(
            onChanged: (value) async {
              controller.searchUer(search: value);
            },
          ),
          actions: [
            // Center(
            //   child: GestureDetector(
            //     onTap: () async {
            //       controller.sortUserBy();
            //     },
            //     child: badges.Badge(
            //       showBadge: controller.listUsers.isEmpty ? false : true,
            //       badgeContent: Text(controller.listUsers.length.toString()),
            //       child: Icon(
            //         Icons.menu_sharp,
            //         size: 30,
            //       ),
            //     ),
            //   ),
            // ),
            Center(
              child: badges.Badge(
                showBadge: controller.listUsers.isEmpty ? false : true,
                badgeContent: Text(controller.listUsers.length.toString()),
                child: const Icon(
                  Icons.person_outline_rounded,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  onTap: () async {
                    controller.initUserControl(
                        user: controller.listUsers[index]);
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text(
                              'Do you want to update \n${controller.listUsers[index].name.toString()}?.'),
                          content: Container(
                            height: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CupertinoTextField(
                                    controller: controller.nameController),
                                CupertinoTextField(
                                  controller: controller.salaryController,
                                  keyboardType: TextInputType.number,
                                ),
                                CupertinoTextField(
                                    controller: controller.positionController),
                                CupertinoTextField(
                                  controller: controller.ageController,
                                  keyboardType: TextInputType.number,
                                ),
                                CupertinoTextField(
                                  controller: controller.expController,
                                )
                              ],
                            ),
                          ),
                          actions: [
                            CupertinoButton(
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            CupertinoButton(
                              child: const Text(
                                'Update',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () async {
                                controller
                                    .updateUser(
                                        id: controller.listUsers[index].id!)
                                    .then((value) {
                                  if (value) {
                                    Get.back();
                                  }
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onLongPress: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text(
                              'Do you want to delete \n${controller.listUsers[index].name.toString()}?.'),
                          actions: [
                            CupertinoButton(
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            CupertinoButton(
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () async {
                                controller
                                    .deleteUser(
                                        id: controller.listUsers[index].id!)
                                    .then((value) {
                                  if (value) {
                                    Get.back();
                                  }
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  title: Text(controller.listUsers[index].name.toString()),
                  subtitle: Text(
                      'Exp: ${controller.listUsers[index].experience.toString()}'),
                  trailing: Column(
                    children: [
                      Text(controller.listUsers[index].position.toString(),
                          style: const TextStyle(fontSize: 16)),
                      Text(
                        '\$ ${controller.listUsers[index].salary}',
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ],
                  ),
                ),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: controller.listUsers.length),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final faker = Faker();
            controller.addUser(
                user: UserModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    name: faker.person.name(),
                    salary: 150.0,
                    age: random.decimal(min: 1, scale: 100).toInt(),
                    position: faker.job.title(),
                    experience: 'Flutter 0year'));
          },
          child: const Icon(Icons.person_add_alt_1),
        ),
      );
    });
  }
}
