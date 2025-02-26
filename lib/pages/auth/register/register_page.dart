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
        return Obx(
          () {
            return Scaffold(
              body: SafeArea(
                child: SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: PageView(
                            controller: ctrl.pageController,
                            // allowImplicitScrolling: false,
                            scrollDirection: Axis.horizontal,
                            scrollBehavior: const ScrollBehavior(),
                            // physics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (index) => ctrl.index.value = index,
                            children: ctrl.pages,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SmoothPageIndicator(
                                count: ctrl.pages.length,
                                controller: ctrl.pageController,
                                effect: WormEffect(
                                  dotWidth: Responsive.width(2.5),
                                  dotHeight: Responsive.width(1.5),
                                  activeDotColor: Get.theme.colorScheme.primary,
                                  dotColor: Get
                                      .theme.colorScheme.onPrimaryContainer
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                              const Spacer(),

                              // Skip
                              if (ctrl.index.value == 0)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  onPressed: ctrl.skip,
                                  child: Text(
                                    'Quizás más tarde'.tr,
                                    style: TextStyle(
                                      color: Get.theme.colorScheme.primary,
                                    ),
                                  ),
                                ),

                              if (ctrl.index.value > 1)
                                const SizedBox(width: 24),

                              // Next
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Get.theme.colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed:
                                    ctrl.errors.isEmpty ? ctrl.next : null,
                                child: Icon(
                                  Icons.arrow_forward_outlined,
                                  color: Get.theme.colorScheme.onPrimary,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
