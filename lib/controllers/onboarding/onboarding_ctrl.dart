import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/pages/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OnboardingCtrl extends GetxController {
  RxInt index = 0.obs;
  RxBool viewed = true.obs;
  RxBool loading = true.obs;
  final PageController pageController = PageController();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  List<Widget> onboardingItems = [
    OnboardingItem(
      image: 'assets/images/onboarding1.svg',
      title: 'Catálogo de productos'.tr,
      description:
          'Descubre una gran variedad de productos para satisfacer todas tus necesidades.'
              .tr,
    ),
    OnboardingItem(
      image: 'assets/images/onboarding2.svg',
      title: 'Financiamiento flexible'.tr,
      description:
          'Compra ahora y paga después con nuestros planes flexibles.'.tr,
    ),
    OnboardingItem(
      image: 'assets/images/onboarding3.svg',
      title: 'Pagos seguros'.tr,
      description:
          'Realiza tus compras con total tranquilidad, tus datos están seguros con nosotros.'
              .tr,
    ),
    OnboardingItem(
      image: 'assets/images/onboarding4.svg',
      title: 'Envío confiable'.tr,
      description: 'Disfruta de envíos rápidos y seguros a todo el país.'.tr,
    ),
    OnboardingItem(
      image: 'assets/images/onboarding5.svg',
      title: 'Atención 24/7'.tr,
      description:
          'Contamos con un equipo de atención al cliente siempre dispuesto a resolver tus dudas.'
              .tr,
    ),
  ];

  @override
  void onInit() async {
    // await secureStorage.write(
    //     key: StorageKeys.storageItemOnboarding, value: 'false');
    Future.delayed(
      const Duration(seconds: 2),
      () => secureStorage.read(key: StorageKeys.storageItemOnboarding).then(
        (value) {
          //
          if (value == 'true') {
            Get.offAllNamed(AppRouteName.authLogin);
          } else {
            viewed.value = false;
            loading.value = false;
          }
        },
      ),
    );

    super.onInit();
  }

  void next() {
    pageController.nextPage(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );

    if (index.value == onboardingItems.length - 1) {
      skip();
    }
  }

  void skip() {
    secureStorage
        .write(key: StorageKeys.storageItemOnboarding, value: 'true')
        .then((value) => Get.offAllNamed(AppRouteName.authLogin));
  }
}
