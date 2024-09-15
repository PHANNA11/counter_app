import 'package:counter_app/counter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Screen2 extends StatelessWidget {
  Screen2({
    super.key,
  });
  final controller = Get.put(CounterController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CounterController>(builder: (contextGext) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Screen2'),
         
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '${controller.number.value}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: () {
                controller.decrement();
              },
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: () {
                controller.increment();
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      );
    });
  }
}
