import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/controllers/index.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

class HomeLayoutPage extends StatelessWidget {
  const HomeLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PermissionsCtrl());
    Get.put(NotificationCtrl());

    return GetBuilder<HomeCtrl>(
      init: HomeCtrl(),
      builder: (ctrl) => Obx(() {
        return Scaffold(
          body: PageView(
            allowImplicitScrolling: false,
            controller: ctrl.pageController,
            scrollDirection: Axis.horizontal,
            scrollBehavior: const ScrollBehavior(),
            physics: const NeverScrollableScrollPhysics(),
            children: ctrl.pages,
          ),
          bottomNavigationBar: FlashyTabBar(
            showElevation: false,
            selectedIndex: ctrl.currentPage.value,
            onItemSelected: (index) {
              ctrl.currentPage.value = index;
              ctrl.pageController.animateToPage(
                ctrl.currentPage.value,
                curve: Curves.easeOutCirc,
                duration: const Duration(milliseconds: 500),
              );
            },
            items: [
              FlashyTabBarItem(
                icon: const Icon(Icons.home_filled),
                title: const Text('Inicio'),
                activeColor: Get.theme.primaryColor,
                inactiveColor: Get.theme.colorScheme.secondaryFixedDim,
              ),
              FlashyTabBarItem(
                icon: const Icon(Icons.search),
                title: const Text('Buscar'),
                activeColor: Get.theme.primaryColor,
                inactiveColor: Get.theme.colorScheme.secondaryFixedDim,
              ),
              FlashyTabBarItem(
                icon: const Icon(Icons.history),
                title: const Text('Historial'),
                activeColor: Get.theme.primaryColor,
                inactiveColor: Get.theme.colorScheme.secondaryFixedDim,
              ),
              FlashyTabBarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Configuración'),
                activeColor: Get.theme.primaryColor,
                inactiveColor: Get.theme.colorScheme.secondaryFixedDim,
              ),
            ],
          ),
        );
      }),
    );
  }
}
