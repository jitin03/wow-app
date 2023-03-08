

import 'dart:math';

import 'package:flutter/material.dart';

ValueNotifier<List<String>> numbers = ValueNotifier(['123']);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: numbers,
          builder: (BuildContext context, List<String> nums, Widget child) {
            return ListView.builder(
              itemCount: numbers.value.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(nums[index]),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.star),
          onPressed: () {
            numbers.value.add(Random().nextInt(1000).toString());
          },
        ),
      ),
    );
  }
}
