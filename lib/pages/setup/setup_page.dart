import 'package:confiao/controllers/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetupCtrl>(
        init: SetupCtrl(),
        builder: (ctrl) => const Center(child: Text('Setup Page')));
  }
}
