import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetupCtrl>(
        init: SetupCtrl(),
        autoRemove: false,
        builder: (ctrl) => Obx(() {
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
                              onPageChanged: (index) =>
                                  ctrl.index.value = index,
                              allowImplicitScrolling: false,
                              controller: ctrl.pageController,
                              scrollDirection: Axis.horizontal,
                              scrollBehavior: const ScrollBehavior(),
                              physics: const NeverScrollableScrollPhysics(),
                              children: ctrl.pages,
                            ),
                          ),
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
                                  dotColor: Get
                                      .theme.colorScheme.onErrorContainer
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
                                      color: Get.theme.colorScheme.error,
                                    ),
                                  ),
                                ),

                              // Back
                              if (ctrl.index.value >= 1)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  onPressed: ctrl.back,
                                  child: Text(
                                    'Volver'.tr,
                                    style: TextStyle(
                                      color: Get.theme.colorScheme.error,
                                    ),
                                  ),
                                ),

                              if (ctrl.index.value > 1)
                                const SizedBox(width: 24),

                              // Next
                              if (ctrl.index.value != 1)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Get.theme.colorScheme.error,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: ctrl.next,
                                  child: Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Get.theme.colorScheme.onPrimary,
                                  ),
                                ),

                              if (ctrl.index.value == 1)
                                ElevatedButton.icon(
                                  iconAlignment: IconAlignment.end,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 14.0,
                                    ),
                                    backgroundColor:
                                        Get.theme.colorScheme.error,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: ctrl.selectedTerminos.value ==
                                              true &&
                                          ctrl.selectedPrivacidad.value == true
                                      ? ctrl.next
                                      : null,
                                  icon: Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Get.theme.colorScheme.onPrimary,
                                  ),
                                  label: Text(
                                    'Finalizar'.tr,
                                    style: TextStyle(
                                      color: Get.theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
