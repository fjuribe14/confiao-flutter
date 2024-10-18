import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterCtrl>(
      init: RegisterCtrl(),
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: Get.theme.primaryColor,
          body: SafeArea(
            child: Obx(() {
              return Container(
                width: Get.width,
                height: Get.height,
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: PageView(
                        allowImplicitScrolling: false,
                        controller: ctrl.pageController,
                        scrollDirection: Axis.horizontal,
                        scrollBehavior: const ScrollBehavior(),
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) => ctrl.index.value = index,
                        children: ctrl.pages,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SmoothPageIndicator(
                          count: ctrl.pages.length,
                          controller: ctrl.pageController,
                          effect: WormEffect(
                            dotWidth: Responsive.width(2.5),
                            dotHeight: Responsive.width(1.5),
                            activeDotColor: Get.theme.colorScheme.error,
                            dotColor: Get.theme.colorScheme.onErrorContainer
                                .withOpacity(0.3),
                          ),
                        ),

                        if (ctrl.index.value == 0) const Spacer(),

                        if (ctrl.index.value >= 1) const SizedBox(width: 24),

                        // Back
                        if (ctrl.index.value >= 1)
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Get.theme.colorScheme.error,
                              ),
                              onPressed: ctrl.next,
                              child: Text(
                                'Finalizar'.tr,
                                style: TextStyle(
                                  color: Get.theme.colorScheme.onError,
                                ),
                              ),
                            ),
                          ),

                        // Next
                        if (ctrl.index.value != 1)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Get.theme.colorScheme.error,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: ctrl.errors.isEmpty ? ctrl.next : null,
                            child: Icon(
                              Icons.arrow_forward_outlined,
                              color: Get.theme.colorScheme.onPrimary,
                            ),
                          )
                      ],
                    )
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
