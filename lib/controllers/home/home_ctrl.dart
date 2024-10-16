import 'package:confiao/pages/index.dart';
import 'package:confiao/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCtrl extends GetxController {
  RxInt currentPage = 0.obs;

  final PageController pageController = PageController();

  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const HistoryPage(),
    const SettingsPage(),
  ];
}
