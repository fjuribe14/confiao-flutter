import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(height: Get.height / 2, color: Colors.red),
            Container(height: Get.height / 2, color: Colors.blue),
            Container(height: Get.height / 2, color: Colors.green),
            Container(height: Get.height / 2, color: Colors.orange),
          ],
        ),
      ),
    );
  }
}
