import 'dart:math';

import 'package:counter_app/user/controller/list_user_controller.dart';
import 'package:counter_app/user/model/user_model.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

class ListUserScreen extends StatelessWidget {
  ListUserScreen({super.key});
  final controller = Get.put(ListUserController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListUserController>(builder: (contextGetx) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('List Infor'),
          actions: [
            Center(
              child: badges.Badge(
                showBadge: controller.listUsers.isEmpty ? false : true,
                badgeContent: Text(controller.listUsers.length.toString()),
                child: Icon(
                  Icons.person_outline_rounded,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  title: Text(controller.listUsers[index].name.toString()),
                  subtitle:
                      Text('Age ${controller.listUsers[index].age.toString()}'),
                  trailing: Column(
                    children: [
                      Text(controller.listUsers[index].position.toString(),
                          style: TextStyle(fontSize: 16)),
                      Text(
                        '\$ ${controller.listUsers[index].salary}',
                        style: TextStyle(color: Colors.red, fontSize: 16),
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
                    salary: 200.0,
                    age: random.decimal(min: 1, scale: 100).toInt(),
                    position: faker.job.title()));
          },
          child: Icon(Icons.person_add_alt_1),
        ),
      );
    });
  }
}
